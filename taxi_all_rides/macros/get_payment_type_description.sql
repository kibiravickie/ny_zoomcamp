{% macro get_payment_type_description(payment_type) %}
case {{payment_type}}
    When 1 then 'Credit Card'
    When 2 then 'Cash'
    When 3 then 'No Charge'
    When 4 then 'Dispute'
    When 5 then 'Unknown'
    When 6 then 'Voided Trip'
    else 'Unknown'
end
{% endmacro %}
