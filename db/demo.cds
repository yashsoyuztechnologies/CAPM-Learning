namespace yashdb;

using {yashdb.constants as const} from './constants';
using { cuid, temporal, managed } from '@sap/cds/common';



context master {
    // start creating the database tables
    entity student : const.address {
        key ID     : const.Guid;
            NAME   : String(80);
            CLASS  : Association to one standards;
            GENDER : String(1);
    }

    entity standards {
        key ID           : Int16;
            CLASSNAME    : String(80);
            SECTIONS     : Int16;
            CLASSTEACHER : String(80);
    }

    entity books {
        key ID       : const.Guid;
            BOOKNAME : String(80);
            AUTHOR   : String(80);

    }
}

context trans {
    entity rentals : cuid ,temporal , managed{
        student: Association to one master.student;
        books: Association to one master.books;
    }
}
