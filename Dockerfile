FROM armbuild/scw-distrib-ubuntu:trusty

WORKDIR /
RUN mkdir -p /stemcell_builder
ADD bosh-master/stemcell_builder /stemcell_builder/
ADD run_stage.sh /run_stage.sh


#ENV STAGES "bosh_sudoers bosh_users"
ENV bosh_users_password "c1oudc0w"
RUN mkdir /tmp/stemcell
RUN ln -s / /tmp/stemcell/chroot 
RUN touch /settings

RUN wget http://dave.cheney.net/paste/go1.5.2.linux-arm.tar.gz
RUN sudo tar -C /usr/local -xzf go1.5.2.linux-arm.tar.gz 

ENV GOROOT=/usr/local/go
ENV PATH=$PATH:$GOROOT/bin
RUN mkdir -p /var/vcap/bosh/bin
RUN mkdir -p /home/vcap
RUN mkdir -p /lib64
#RUN mkdir -p /chroot

#ENV STAGES "bosh_ruby  bosh_go_agent  bosh_micro_go  aws_cli  logrotate_config  base_debootstrap  base_ubuntu_firstboot  base_apt  base_ubuntu_build_essential  base_ubuntu_packages  base_file_permission  base_ssh  bosh_sysstat  system_kernel  system_kernel_modules  system_ixgbevf  bosh_sysctl  bosh_users  bosh_monit  bosh_ntpdate  bosh_sudoers  disable_blank_passwords  rsyslog_config  delay_monit_start  system_grub  vim_tiny  cron_config  escape_ctrl_alt_del"

ENV STAGES "bosh_ruby bosh_go_agent base_file_permission base_ssh bosh_users bosh_monit bosh_sudoers"
RUN /run_stage.sh "$STAGES" /tmp/stemcell /settings

