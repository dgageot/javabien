workflow "SayHello" {
  on = "issues"
  resolves = "hello"
}

action "hello" {
  uses = "./hello/"
  env = {
    GREETING  = "David"
  }
}