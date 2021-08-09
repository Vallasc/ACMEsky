import { Flight } from "./flight";

export class Notification {
    _id: string;
    flyBack: Flight;
    flyOutBound: Flight;
    offerToken: string;
    username: string;
    message: string;
}
