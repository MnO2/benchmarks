#![feature(libc)] extern crate libc;
use libc::funcs::posix88::unistd::read;
use libc::funcs::posix88::fcntl::open;
use libc::consts::os::posix88::O_RDONLY;
use libc::consts::os::posix88::S_IREAD;
use libc::types::common::c95::c_void;
use std::ffi::CString;
use std::str;
use std::collections::HashMap;

fn main() {
    let path_str = CString::new("large_random.txt").unwrap();
    let fd = unsafe {
        open(path_str.as_ptr(), O_RDONLY, S_IREAD)
    };

    let mut buf: Vec<u8> = Vec::with_capacity(512);
    let mut M: HashMap<String, u32> = HashMap::new();

    loop {
        let nread = unsafe { read(fd, buf.as_mut_ptr() as *mut c_void, 512) };
        let s = str::from_utf8(buf.as_slice()).ok().expect("from_utf8 error");
        let ss = String::from_str(s);
        if M.contains_key(&ss) {
            match M.get_mut(&ss) {
                Some(x) => { *x += 1 },
                None => ()
            };
        } else {
            M.insert(ss, 1);
        }

        if nread == 0 {
            break;
        };
    }
}
