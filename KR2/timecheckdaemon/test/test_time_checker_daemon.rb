require 'minitest/autorun'
require_relative '../timecheckerdaemon'

class TestTimeCheckerDaemon < Minitest::Test
  def test_daemon_starts_and_stops
    daemon = TimeCheckerDaemon.new(1)
    assert_equal false, daemon.running, 'Daemon should not be running initially'

    daemon.start
    sleep(1)
    assert_equal true, daemon.running, 'Daemon should be running after start'

    daemon.stop
    assert_equal false, daemon.running, 'Daemon should not be running after stop'
  end

  def test_daemon_does_not_run_multiple_threads
    daemon = TimeCheckerDaemon.new(1)
    daemon.start
    thread_count_before = Thread.list.size

    daemon.start
    thread_count_after = Thread.list.size

    daemon.stop

    assert_equal thread_count_before, thread_count_after, 'Daemon should not create multiple threads on repeated start'
  end
end