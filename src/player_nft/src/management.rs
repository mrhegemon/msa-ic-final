use ic_kit::{candid::CandidType, ic, Principal};
use serde::Deserialize;

#[derive(CandidType, Deserialize)]
pub struct Admins(pub Vec<Principal>);

impl Default for Admins {
    fn default() -> Self {
        panic!()
    }
}

pub fn is_admin(account: &Principal) -> bool {
    ic::get::<Admins>().0.contains(account)
}
