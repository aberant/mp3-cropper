class Worker

  def exec
    if @child = Kernel.fork
      Process.wait
    else
      10.times { sleep 5; puts "hi"}
      exit!
    end
  end
end