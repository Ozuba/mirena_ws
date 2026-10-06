#ifndef MIRENA_CONTROL__CAR_DISPLAY_HPP_
#define MIRENA_CONTROL__CAR_DISPLAY_HPP_

#include <deque>
#include <memory>

#include "mirena_common/msg/car.hpp"
#include <rviz_common/ros_topic_display.hpp>
#include <rviz_common/properties/color_property.hpp>
#include <rviz_common/properties/float_property.hpp>
#include <rviz_common/properties/bool_property.hpp>
#include <rviz_common/properties/int_property.hpp>

#include <rviz_rendering/objects/shape.hpp>
#include <rviz_rendering/objects/arrow.hpp>
#include <rviz_rendering/objects/movable_text.hpp>
#include <rviz_rendering/objects/billboard_line.hpp>

namespace mirena
{
class CarDisplay : public rviz_common::RosTopicDisplay<mirena_common::msg::Car>
{
  Q_OBJECT

public:
  CarDisplay();
  ~CarDisplay() override;

protected:
  void onInitialize() override;
  void reset() override;
  void processMessage(mirena_common::msg::Car::ConstSharedPtr msg) override;

private Q_SLOTS:
  void updateVisualConfigs();

private:
  void updateCarText(const mirena_common::msg::Car::ConstSharedPtr& msg);
  void updateCovariance(const mirena_common::msg::Car::ConstSharedPtr& msg);
  void updateVelocityArrow(const mirena_common::msg::Car::ConstSharedPtr& msg);
  void updateTrail(const Ogre::Vector3& world_pos);

  // Property Handles
  rviz_common::properties::ColorProperty* color_p_;
  rviz_common::properties::FloatProperty* mesh_scale_p_;
  rviz_common::properties::BoolProperty* show_cov_p_;
  rviz_common::properties::BoolProperty* show_vel_p_;
  rviz_common::properties::FloatProperty* vel_scale_p_;
  rviz_common::properties::IntProperty* trail_length_p_;

  // Ogre Scene Objects
  Ogre::SceneNode* car_node_;
  std::unique_ptr<rviz_rendering::Shape> car_mesh_;
  std::unique_ptr<rviz_rendering::Arrow> vel_arrow_u_; // Longitudinal (X)
  std::unique_ptr<rviz_rendering::Arrow> vel_arrow_v_; // Lateral (Y)
  std::unique_ptr<rviz_rendering::Shape> covariance_ellipse_;
  std::unique_ptr<rviz_rendering::MovableText> car_text_;
  std::unique_ptr<rviz_rendering::BillboardLine> trail_line_;
  
  std::deque<Ogre::Vector3> trail_points_;
};
} // namespace mirena

#endif