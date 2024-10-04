# Define the database connection to be used for this model.
connection: "the_look_ecommerce"

# include all the views
include: "/views/**/*.view.lkml"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: the_look_ecommerce_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}
persist_with: the_look_ecommerce_default_datagroup

# ecommerce.model.lkml

explore: orders {
  label: "Orders"
  view_name: orders

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: order_items {
    type: left_outer
    sql_on: ${orders.order_id} = ${order_items.order_id} ;;
    relationship: one_to_many
  }

  join: products {
    type: left_outer
    sql_on: ${order_items.product_id} = ${products.id} ;;
    relationship: many_to_one
    required_joins: [order_items]
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
    required_joins: [order_items]
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
    required_joins: [products]
  }
}

explore: users {
  label: "Users"
  view_name: users

  join: orders {
    type: left_outer
    sql_on: ${users.id} = ${orders.user_id} ;;
    relationship: one_to_many
  }

  join: order_items {
    type: left_outer
    sql_on: ${users.id} = ${order_items.user_id} ;;
    relationship: one_to_many
  }

  join: events {
    type: left_outer
    sql_on: ${users.id} = ${events.user_id} ;;
    relationship: one_to_many
  }
}

explore: products {
  label: "Products"
  view_name: products

  join: inventory_items {
    type: left_outer
    sql_on: ${products.id} = ${inventory_items.product_id} ;;
    relationship: one_to_many
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }

  join: order_items {
    type: left_outer
    sql_on: ${products.id} = ${order_items.product_id} ;;
    relationship: one_to_many
  }
}

explore: inventory_items {
  label: "Inventory Items"
  view_name: inventory_items

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${inventory_items.product_distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: events {
  label: "Events"
  view_name: events

  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  label: "Order Items"
  view_name: order_items

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${order_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }
}

explore: distribution_centers {
  label: "Distribution Centers"
  view_name: distribution_centers

  join: products {
    type: left_outer
    sql_on: ${distribution_centers.id} = ${products.distribution_center_id} ;;
    relationship: one_to_many
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${distribution_centers.id} = ${inventory_items.product_distribution_center_id} ;;
    relationship: one_to_many
  }
}
