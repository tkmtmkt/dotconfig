{
  # ls
  l   = "ls -CF";
  la  = "ls -A";
  lh  = "ls -lh";
  ll  = "ls -lF";
  ltr = "ls -ltr";
  lz  = "ls -Z";

  ".." = "cd ..";
  less = "less -R ";
  path = "echo $PATH | sed 's/:/\\n/g'";
  tree = "tree -F --dirsfirst --charset=ascii";

  # tmux
  tmls = "tmux list-session ";
  tmas = "tmux attach-session -t ";
  tmks = "tmux kill-session -t ";
  tmrs = "tmux rename-session -t ";
  tmns = "tmux new -s ";
  tmlw = "tmux list-windows -t ";
  tmnw = "tmux new-window -n ";
  tmkw = "tmux kill-window -t ";
  tmlp = "tmux list-panes -t ";
  tmrl = "tmux source-file ~/.tmux.conf";
  tmd  = "tmux detach ";
}
