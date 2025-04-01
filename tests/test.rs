use jenkins_test_rust::{add, divide};

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(2, 3), 5);
    }

    #[test]
    fn test_divide_ok() {
        assert_eq!(divide(10, 2), Ok(5));
    }

    #[test]
    fn test_divide_err() {
        assert_eq!(divide(10, 0), Err(String::from("Cannot divide by zero")));
    }
}
