class AddTrigger < ActiveRecord::Migration

  def up
    execute %q{
CREATE OR REPLACE FUNCTION notify_pricesinserted()
  RETURNS trigger AS $$
DECLARE
BEGIN
  PERFORM pg_notify(
    CAST('pricesinserted' AS text),
    row_to_json(NEW)::text
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER notify_pricesinserted
  AFTER INSERT ON prices
  FOR EACH ROW
  EXECUTE PROCEDURE notify_pricesinserted();
}
  end

  def down
    execute "DROP TRIGGER IF EXISTS notify_pricesinserted ON prices;"
    execute "DROP FUNCTION IF EXISTS notify_pricesinserted();"
  end
end
