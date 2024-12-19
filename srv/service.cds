using {
    yashdb.master as master,
    yashdb.trans as transaction
} from '../db/demo';


service LibraryService {

    entity StudentSet as projection on master.student;
    entity BookSet as projection on master.books;
    entity StandardSet as projection on master.standards;
    entity BookRentalSet as projection on transaction.rentals;

}
