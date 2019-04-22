// System call numbers
#define SYS_fork    1
#define SYS_exit    2
#define SYS_wait    3
#define SYS_pipe    4
#define SYS_read    5
#define SYS_kill    6
#define SYS_exec    7
#define SYS_fstat   8
#define SYS_chdir   9
#define SYS_dup    10
#define SYS_getpid 11
#define SYS_sbrk   12
#define SYS_sleep  13
#define SYS_uptime 14
#define SYS_open   15
#define SYS_write  16
#define SYS_mknod  17
#define SYS_unlink 18
#define SYS_link   19
#define SYS_mkdir  20
#define SYS_close  21
//custom from here on ---------------------------------------------------------------------------------------------------------
#define SYS_toggle 22//new added for sys toggle
#define SYS_add    23//added on 11 Feb for sys_add
#define SYS_ps     24//added for printing list of current processes
#define SYS_send   25//send
#define SYS_recv   26//receiver
#define SYS_print_count 27//printing number of system calls called
#define SYS_send_multi 28
// ----------Signals--------------------------------------------------------------------
#define SYS_signal 29
#define SYS_sigraise 30
#define SYS_halt   31
#define SYS_recv_multi 32
#define SYS_change_state 33
#define SYS_create_container 34
#define SYS_destroy_container 35
#define SYS_join_container 36
#define SYS_leave_container 37
#define SYS_scheduler_log_on 38
#define SYS_scheduler_log_off 39
#define SYS_container_malloc 40
#define SYS_memory_log_on 41
#define SYS_memory_log_off 42
#define SYS_get_file_container_id 43
#define SYS_get_container_id 44