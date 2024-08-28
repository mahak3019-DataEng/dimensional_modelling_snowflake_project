import snowflake.connector
import csv

# Configure Snowflake connection
conn = snowflake.connector.connect(
    user='<username>',
    password='<password>',
    account='<account>',
    warehouse='<warehouse>',
    database='<database>',
    schema='<schema>'
)
try:
    # Create a cursor object
    cur1 = conn.cursor()

    # Execute SQL query
    cur1.execute("""
        SELECT d.department,
               COUNT(*) AS total_products_ordered
        FROM fact_order_products op 
        JOIN dim_departments d ON d.department_id = op.department_id
        GROUP BY d.department;
    """)

    # Fetch all results
    results = cur1.fetchall()

    #Writing another query
    cur2 = conn.cursor()
    cur2.execute("""
        select a.aisle,
                 count(*) as total_reordered 
        from fact_order_products op 
        join dim_aisles a on a.aisle_id = op.aisle_id
        where op.reordered = TRUE
        group by a.aisle
        order by total_reordered DESC;
    """)
    total_results = cur2.fetchall()

    # Write results to a CSV file
    with open('department_ordered', 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['department', 'total_products_ordered'])  # Write header
        writer.writerows(results)  # Write data

    with open('aisles_ordered','w',newline='') as file:
        writer= csv.writer(file)
        writer.writerow(['Aisle','Total_reordered'])
        writer.writerows(total_results)

finally:
    # Ensure the cursor and connection are closed even if an error occurs
    cur1.close()
    cur2.close()
    conn.close()