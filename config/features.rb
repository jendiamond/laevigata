Flipflop.configure do
  feature :read_only,
          default: false,
          description: "Put the system into read-only mode. Deposits, edits, approvals and anything that makes a change to the data will be disabled. For use in "
  feature :old_school_ui,
          default: false,
          description: "Use a server-side driven html form based submission UI"
end
