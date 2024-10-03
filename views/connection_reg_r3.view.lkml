# The name of this view in Looker is "Connection Reg R3"
view: connection_reg_r3 {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `the_look_ecommerce.connection_reg_r3` ;;
  drill_fields: [reg_key]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: reg_key {
    primary_key: yes
    type: string
    sql: ${TABLE}.reg_key ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Created At" in Explore.

  dimension: created_at {
    type: number
    sql: ${TABLE}.created_at ;;
  }

  dimension: expires_at {
    type: number
    sql: ${TABLE}.expires_at ;;
  }

  dimension: looker {
    type: string
    sql: ${TABLE}.looker ;;
  }
  measure: count {
    type: count
    drill_fields: [reg_key]
  }
}
