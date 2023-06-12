package infracost # your policy files must be under the "infracost" package

# This example shows you how you can create a policy that will fail if the infracost `diffTotalMonthlyCost`
# value is greater than 100 dollars.
deny[out] {
	# maxDiff defines the threshold that you require the cost estimate to be below.
	maxDiff = 100.0

	# msg defines the output that will be shown in PR comments under the Policy Checks/Failures section.
	msg := sprintf(
		"Total monthly cost diff must be less than $%.2f (actual diff is $%.2f)",
		[maxDiff, to_number(input.monthly_cost)],
	)

	# out defines the output for this policy. This output must be formatted with a `msg` and `failed` property.
  	out := {
    	# the msg you want to display in your PR comment
    	"msg": to_number(input.monthly_cost),
        # a boolean value that determines if this policy has failed.
        # In this case if the Infracost breakdown output diffTotalMonthlyCost is greater that $10.
    	"failed": to_number(input.monthly_cost) >= maxDiff
  	}
}