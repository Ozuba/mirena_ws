#include "car_display.hpp"
#include <rviz_common/display_context.hpp>
#include <rviz_common/frame_manager_iface.hpp>
#include <Eigen/Dense>
#include <iomanip>
#include <sstream>

namespace mirena
{

CarDisplay::CarDisplay()
{
  color_p_ = new rviz_common::properties::ColorProperty("Color", QColor(255, 0, 0), "Car body color", this, SLOT(updateVisualConfigs()));
  mesh_scale_p_ = new rviz_common::properties::FloatProperty("Scale", 1.0f, "Mesh scale", this, SLOT(updateVisualConfigs()));
  show_cov_p_ = new rviz_common::properties::BoolProperty("Show Covariance", true, "Show uncertainty ellipse", this);
  show_vel_p_ = new rviz_common::properties::BoolProperty("Show Velocity", true, "Show velocity vector", this);
  vel_scale_p_ = new rviz_common::properties::FloatProperty("Vel Scale", 0.5f, "Velocity arrow scaling", this);
  trail_length_p_ = new rviz_common::properties::IntProperty("Trail Length", 100, "Number of breadcrumbs", this);
}

CarDisplay::~CarDisplay() {}

void CarDisplay::onInitialize()
{
  // FIX: Explicitly call base class instead of using MFDClass macro
  rviz_common::RosTopicDisplay<mirena_common::msg::Car>::onInitialize();
  
  car_node_ = scene_node_->createChildSceneNode();
  car_mesh_ = std::make_unique<rviz_rendering::Shape>(rviz_rendering::Shape::Cube, scene_manager_, car_node_);
  vel_arrow_u_ = std::make_unique<rviz_rendering::Arrow>(scene_manager_, car_node_);
  vel_arrow_v_ = std::make_unique<rviz_rendering::Arrow>(scene_manager_, car_node_);
  covariance_ellipse_ = std::make_unique<rviz_rendering::Shape>(rviz_rendering::Shape::Cylinder, scene_manager_, car_node_);
  
  trail_line_ = std::make_unique<rviz_rendering::BillboardLine>(scene_manager_, scene_node_);
  trail_line_->setLineWidth(0.03f);

  car_text_ = std::make_unique<rviz_rendering::MovableText>("Waiting for msg...");
  car_text_->setTextAlignment(rviz_rendering::MovableText::H_CENTER, rviz_rendering::MovableText::V_ABOVE);
  car_text_->setCharacterHeight(0.25f);
  car_text_->setLocalTranslation(Ogre::Vector3(0.0, 0.0, 1.2)); 
  car_node_->attachObject(car_text_.get());
}

void CarDisplay::processMessage(mirena_common::msg::Car::ConstSharedPtr msg)
{
  Ogre::Vector3 tf_pos;
  Ogre::Quaternion tf_ori;

 // Use get_clock_type() to match the context's current clock (System or ROS)
rclcpp::Time lookup_time(0, 0, context_->getClock()->get_clock_type());

if (!context_->getFrameManager()->getTransform(msg->header.frame_id, lookup_time, tf_pos, tf_ori))
{
  //setMissingTransformToFixedFrame(msg->header.frame_id);
  return;
}

  Ogre::Vector3 local_pos(msg->x, msg->y, 0.05f);
  Ogre::Quaternion local_ori(Ogre::Radian(msg->psi), Ogre::Vector3::UNIT_Z);

  Ogre::Vector3 global_pos = tf_pos + (tf_ori * local_pos);
  Ogre::Quaternion global_ori = tf_ori * local_ori;

  car_node_->setPosition(global_pos);
  car_node_->setOrientation(global_ori);

  updateVelocityArrow(msg);
  updateCovariance(msg);
  updateTrail(global_pos);
  updateCarText(msg);
  
  updateVisualConfigs();
}

// FIX: Added the '&' to match the header signature
void CarDisplay::updateCarText(const mirena_common::msg::Car::ConstSharedPtr& msg)
{
  auto fmt = [](double val) {
    std::stringstream ss;
    ss << std::fixed << std::setprecision(2) << val;
    return ss.str();
  };

  std::string text = "Position (x, y, psi): (" + fmt(msg->x) + " " + fmt(msg->y) + " " + fmt(msg->psi) + ")\n" +
                     "Vel X: " + fmt(msg->u) + " m/s\n" +
                     "Vel Y: " + fmt(msg->v) + " m/s\n" +
                     "Vel Ang Z: " + fmt(msg->omega) + " rad/s\n";

  car_text_->setCaption(text);
}

void CarDisplay::updateVelocityArrow(const mirena_common::msg::Car::ConstSharedPtr& msg)
{
  bool show = show_vel_p_->getBool();
  float scale = vel_scale_p_->getFloat();

  if (!show) {
    vel_arrow_u_->getSceneNode()->setVisible(false);
    vel_arrow_v_->getSceneNode()->setVisible(false);
    return;
  }

  // --- Longitudinal Arrow (U) ---
  if (std::abs(msg->u) > 0.05f) {
    // Points strictly along Local X (1, 0, 0) - sign(u) handles reverse
    Ogre::Vector3 dir_u(msg->u > 0 ? 1.0f : -1.0f, 0.0f, 0.0f);
    vel_arrow_u_->setDirection(dir_u);
    vel_arrow_u_->setPosition(Ogre::Vector3(0, 0, 0.2f)); // Slightly elevated

    float len = std::abs(msg->u) * scale;
    vel_arrow_u_->set(len * 0.8f, 0.04f, len * 0.2f, 0.12f);
    vel_arrow_u_->setColor(1.0f, 0.0f, 0.0f, 1.0f); // Red for X
    vel_arrow_u_->getSceneNode()->setVisible(true);
  } else {
    vel_arrow_u_->getSceneNode()->setVisible(false);
  }

  // --- Lateral Arrow (V) ---
  if (std::abs(msg->v) > 0.05f) {
    // Points strictly along Local Y (0, 1, 0) - sign(v) handles left/right
    Ogre::Vector3 dir_v(0.0f, msg->v > 0 ? 1.0f : -1.0f, 0.0f);
    vel_arrow_v_->setDirection(dir_v);
    vel_arrow_v_->setPosition(Ogre::Vector3(0, 0, 0.2f));

    float len = std::abs(msg->v) * scale;
    vel_arrow_v_->set(len * 0.8f, 0.04f, len * 0.2f, 0.12f);
    vel_arrow_v_->setColor(0.0f, 1.0f, 0.0f, 1.0f); // Green for Y
    vel_arrow_v_->getSceneNode()->setVisible(true);
  } else {
    vel_arrow_v_->getSceneNode()->setVisible(false);
  }
}

void CarDisplay::updateCovariance(const mirena_common::msg::Car::ConstSharedPtr& msg)
{
  if (!show_cov_p_->getBool()) {
    covariance_ellipse_->getRootNode()->setVisible(false);
    return;
  }

  Eigen::Matrix2f cov;
  cov << msg->covariance[0], msg->covariance[1],
         msg->covariance[6], msg->covariance[7];

  Eigen::SelfAdjointEigenSolver<Eigen::Matrix2f> solver(cov);
  
  float angle = std::atan2(solver.eigenvectors()(1, 0), solver.eigenvectors()(0, 0));
  float sx = 2.0f * std::sqrt(std::max(solver.eigenvalues()[0], 1e-4f));
  float sy = 2.0f * std::sqrt(std::max(solver.eigenvalues()[1], 1e-4f));

  Ogre::Quaternion align_with_odom = car_node_->getOrientation().Inverse();
  
  covariance_ellipse_->setOrientation(align_with_odom * 
                                      Ogre::Quaternion(Ogre::Radian(angle), Ogre::Vector3::UNIT_Z) * 
                                      Ogre::Quaternion(Ogre::Radian(M_PI/2), Ogre::Vector3::UNIT_X));
  
  covariance_ellipse_->setScale(Ogre::Vector3(sx, 0.01f, sy));
  covariance_ellipse_->setColor(1.0f, 1.0f, 0.0f, 0.35f); 
  covariance_ellipse_->getRootNode()->setVisible(true);
}

void CarDisplay::updateTrail(const Ogre::Vector3& world_pos)
{
  trail_points_.push_back(world_pos);
  if (trail_points_.size() > (size_t)trail_length_p_->getInt()) {
    trail_points_.pop_front();
  }

  trail_line_->clear();
  // FIX: Removed setMaxPoints as it is not present in RViz2 BillboardLine
  for (const auto& p : trail_points_) {
    trail_line_->addPoint(p);
  }
}

void CarDisplay::updateVisualConfigs()
{
  float s = mesh_scale_p_->getFloat();
  car_mesh_->setScale(Ogre::Vector3(1.2f * s, 0.7f * s, 0.3f * s));
  car_mesh_->setColor(color_p_->getOgreColor());
}

void CarDisplay::reset()
{
  // FIX: Explicitly call base class instead of using MFDClass macro
  rviz_common::RosTopicDisplay<mirena_common::msg::Car>::reset();
  trail_points_.clear();
  if (trail_line_) trail_line_->clear();
}

} // namespace mirena

#include <pluginlib/class_list_macros.hpp>
PLUGINLIB_EXPORT_CLASS(mirena::CarDisplay, rviz_common::Display)