#include <rviz_common/message_filter_display.hpp>
#include <mirena_common/msg/track.hpp>
#include <rviz_rendering/objects/movable_text.hpp>

#include <OgreManualObject.h>
#include <OgreSceneNode.h>
#include <OgreSceneManager.h>

namespace mirena
{

class TrackDisplay : public rviz_common::MessageFilterDisplay<mirena_common::msg::Track>
{
public:
    TrackDisplay() : manual_object_(nullptr) {}

    ~TrackDisplay() override { clear(); }

protected:
    void onInitialize() override
    {
        MFDClass::onInitialize();
        parent_node_ = scene_node_->createChildSceneNode();
    }

    void processMessage(mirena_common::msg::Track::ConstSharedPtr msg) override
    {
        update_mesh(msg);

        // Standard Transform Logic
        Ogre::Vector3 position;
        Ogre::Quaternion orientation;
        if (!context_->getFrameManager()->getTransform(msg->header, position, orientation))
        {
            setStatus(rviz_common::properties::StatusProperty::Error, "Transform", "TF Error");
            return;
        }
        
        setStatus(rviz_common::properties::StatusProperty::Ok, "Transform", "OK");
        parent_node_->setPosition(position);
        parent_node_->setOrientation(orientation);
    }

private:
    Ogre::ManualObject *manual_object_;
    Ogre::SceneNode *parent_node_;
    
    // We store the pointers to clean them up properly
    std::vector<std::unique_ptr<rviz_rendering::MovableText>> text_objects_;
    std::vector<Ogre::SceneNode*> text_nodes_;

    void update_mesh(mirena_common::msg::Track::ConstSharedPtr msg)
    {
        clear();
        if (msg->gates.empty()) return;

        // Color coding: Green for Closed, White for Open
        Ogre::ColourValue track_color = msg->is_closed ? 
            Ogre::ColourValue(0.0f, 1.0f, 0.0f, 1.0f) : 
            Ogre::ColourValue(1.0f, 1.0f, 1.0f, 1.0f);

        manual_object_ = scene_manager_->createManualObject();
        manual_object_->begin("BaseWhiteNoLighting", Ogre::RenderOperation::OT_LINE_STRIP);

        for (size_t i = 0; i < msg->gates.size(); ++i)
        {
            const auto& gate = msg->gates[i];
            manual_object_->position(gate.x, gate.y, 0.05f);
            manual_object_->colour(track_color);

            // Create the Number Text for this gate
            create_waypoint_text(gate, static_cast<int>(i));
        }

        if (msg->is_closed && msg->gates.size() > 1) {
            manual_object_->position(msg->gates[0].x, msg->gates[0].y, 0.05f);
            manual_object_->colour(track_color);
        }

        manual_object_->end();
        parent_node_->attachObject(manual_object_);
    }

    void create_waypoint_text(const mirena_common::msg::Gate& gate, int index)
    {
        // 1. Create a child node for the text to position it
        Ogre::SceneNode* t_node = parent_node_->createChildSceneNode();
        t_node->setPosition(gate.x, gate.y, 0.5f); // 0.5m above track

        // 2. Create the MovableText just like in CarDisplay
        auto text = std::make_unique<rviz_rendering::MovableText>(std::to_string(index));
        text->setCharacterHeight(0.25);
        text->setTextAlignment(rviz_rendering::MovableText::H_CENTER,
                               rviz_rendering::MovableText::V_ABOVE);
        text->setColor(Ogre::ColourValue::White);

        // 3. Attach and store
        t_node->attachObject(text.get());
        
        text_nodes_.push_back(t_node);
        text_objects_.push_back(std::move(text));
    }

    void clear()
    {
        // Clear Manual Lines
        if (manual_object_) {
            parent_node_->detachObject(manual_object_);
            scene_manager_->destroyManualObject(manual_object_);
            manual_object_ = nullptr;
        }

        // Clear Nodes and Texts
        // We must detach objects before destroying the nodes
        for (size_t i = 0; i < text_nodes_.size(); ++i) {
            if (text_nodes_[i] && text_objects_[i]) {
                text_nodes_[i]->detachObject(text_objects_[i].get());
                scene_manager_->destroySceneNode(text_nodes_[i]);
            }
        }
        
        text_nodes_.clear();
        text_objects_.clear();
    }
};

} // namespace mirena

#include <pluginlib/class_list_macros.hpp>
PLUGINLIB_EXPORT_CLASS(mirena::TrackDisplay, rviz_common::Display)