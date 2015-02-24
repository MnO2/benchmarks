use std::old_io::fs::PathExtensions;
use std::old_io::{File, Open, Read, BufferedStream, IoErrorKind};

fn print_vec(v: &Vec<u8>) {
    for x in v.iter() {
        print!("{}", x);
    }
}

fn main() {
    let path = Path::new("large_random.txt");
    let file = File::open(&path).ok().expect("failed reading file");
    let mut stream = BufferedStream::new(file);

    loop {
        match stream.read_exact(512) {
            Ok(v) => {
            },
            Err(e) => {
                if e.kind == IoErrorKind::EndOfFile  {
                    println!("Done");
                    break;
                } else {
                    println!("error reading: {}", e);
                    break;
                }
            }
        };
    };
}
