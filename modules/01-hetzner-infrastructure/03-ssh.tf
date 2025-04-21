resource "hcloud_ssh_key" "this" {
  for_each = { for idx, key in var.ssh_public_keys : idx => key }
  name = "${var.stage}-key-${each.key}"
  public_key = each.value
}