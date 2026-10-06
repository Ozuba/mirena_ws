#include "entity_list.h"

namespace mirena
{

  EntityListDisplay::EntityListDisplay() : _tf_buffer(std::make_shared<tf2_ros::Buffer>(rclcpp::Clock::make_shared())),
                                           _tf_listener(std::make_shared<tf2_ros::TransformListener>(*_tf_buffer))
  {
    this->_enable_color_override_p = new rviz_common::properties::BoolProperty("Enable Color Override", false, "meow", this);
    this->_color_override_p = new rviz_common::properties::ColorProperty("Entity Color Override", QColor(0, 0, 0, 1), "meowmeow", this, SLOT(update_color_override()));
  }

  EntityListDisplay::~EntityListDisplay()
  {
    clear_entities();
  }

  void EntityListDisplay::onInitialize()
  {
    MFDClass::onInitialize();
    this->_parent_node = this->scene_node_->createChildSceneNode();
  }

  std::shared_ptr<rviz_rendering::Shape> EntityListDisplay::render_entity(const mirena_common::msg::Entity &msg)
  {
    auto cone = std::make_shared<rviz_rendering::Shape>(rviz_rendering::Shape::Type::Cylinder, this->scene_manager_, this->_parent_node);
    cone->setOrientation(Ogre::Quaternion(std::sqrt(0.5), std::sqrt(0.5), 0, 0));
    cone->setScale(Ogre::Vector3(0.2, 0.4, 0.2));
    cone->setColor(202, 176, 190, 0.4);
    cone->setPosition(Ogre::Vector3(msg.position.x, msg.position.y, msg.position.z));

    if (this->_enable_color_override_p->getBool())
    {
      cone->setColor(this->_color_override_p->getOgreColor());
    }
    else
    {
      float r = 0.7f, g = 0.7f, b = 0.7f; // Default grey

      if (msg.type == "cone_blue")
      {
        r = 49.0f / 255.0f;
        g = 29.0f / 255.0f;
        b = 135.0f / 255.0f;
      }
      else if (msg.type == "cone_yellow")
      {
        r = 189.0f / 255.0f;
        g = 196.0f / 255.0f;
        b = 20.0f / 255.0f;
      }
      else if (msg.type == "cone_big_orange")
      {
        r = 254.0f / 255.0f;
        g = 110.0f / 255.0f;
        b = 20.0f / 255.0f;
        cone->setScale(Ogre::Vector3(0.3, 0.6, 0.3)); // Make it beefy
      }
      else if (msg.type == "cone_orange")
      {
        r = 255.0f / 255.0f;
        g = 110.0f / 255.0f;
        b = 0.0f / 255.0f;
      }
      cone->setColor(r, g, b, 0.7);
    }
    return cone;
  }

  void EntityListDisplay::update_transform(const std_msgs::msg::Header &header)
  {
    geometry_msgs::msg::TransformStamped transform;
    try
    {
      transform = this->_tf_buffer->lookupTransform(this->fixed_frame_.toStdString(), header.frame_id, header.stamp);
    }
    catch (tf2::TransformException &ex)
    {
      RCLCPP_WARN(rclcpp::get_logger("EntityListDisplay"), "Transform failed: %s", ex.what());
      setStatus(rviz_common::properties::StatusProperty::Error, "Transform", ex.what());
      return;
    }

    Ogre::Vector3 position(transform.transform.translation.x,
                           transform.transform.translation.y,
                           transform.transform.translation.z);

    Ogre::Quaternion orientation(transform.transform.rotation.w,
                                 transform.transform.rotation.x,
                                 transform.transform.rotation.y,
                                 transform.transform.rotation.z);

    this->_parent_node->setPosition(position);
    this->_parent_node->setOrientation(orientation);

    return;
  }

  void EntityListDisplay::clear_entities()
  {
    this->_parent_node->removeAllChildren();
    this->_meshes.clear();
  }

  void EntityListDisplay::processMessage(mirena_common::msg::EntityList::ConstSharedPtr msg)
  {
    this->clear_entities();

    this->update_transform(msg->header);

    for (const auto &entity_msg : msg->entities)
    {
      auto mesh = this->render_entity(entity_msg);
      this->_meshes.push_back(mesh);
    }
  }

  void EntityListDisplay::update_color_override()
  {
    if (!this->_enable_color_override_p->getBool())
    {
      return;
    }
    for (auto &entity : this->_meshes)
    {
      entity->setColor(this->_color_override_p->getOgreColor());
    }
  }

}

#include <pluginlib/class_list_macros.hpp>
PLUGINLIB_EXPORT_CLASS(mirena::EntityListDisplay, rviz_common::Display)