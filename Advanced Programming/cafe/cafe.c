#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>

typedef struct cafe
{
    int id, amount, qty;
    char item[50], size[10];
    float small, medium, large, price, sugar;
} cafe;

typedef struct account
{
    char username[50];
    char password[50];
} acc;

cafe menu[50];
cafe cart[50];
acc user;
acc data[50];
int menucount;
int account;
int cartcount = 0;
char name[30] = "Guest";
int loggedin = 0;

void viewCart();  // Declare functions
void viewOrder(); // ^

void updateMenu() // Refresh the menu if menu.txt has been altered.
{
    menucount = 0;
    char menubuffer[512]; // Temporary store each line in the file to read.
    FILE *menufile;
    menufile = fopen("menu.txt", "r");
    while (fgets(menubuffer, 512, menufile) != NULL)
    {
        sscanf(menubuffer, "%d %s %f %f %f", &menu[menucount].id, menu[menucount].item, &menu[menucount].small, &menu[menucount].medium, &menu[menucount].large);
        menucount++;
    }
    fclose(menufile);
}

void updateAccount() // Same as updateMenu.
{
    account = 0;
    char accbuffer[500];
    FILE *accfile;
    accfile = fopen("account.txt", "r");
    while (fgets(accbuffer, 500, accfile) != NULL)
    {
        sscanf(accbuffer, "%s %s ", data[account].username, data[account].password);
        account++;
    }
    fclose(accfile);
}

void encryptPassword() // Encrypt the passwords so that you cannot read from the database.
{
    int KEY = 78623; // DO NOT TOUCH
    size_t length = strlen(user.password);
    for (size_t i = 0; i < length; i++)
    {
        user.password[i] = user.password[i] ^ KEY;
    }
}

char *getCurrentTime() // Get the current system time to print into the receipt.
{
    time_t currentTime = time(NULL);
    char *timeString = ctime(&currentTime);

    int length = strlen(timeString);
    if (length > 0 && timeString[length - 1] == '\n')
    {
        timeString[length - 1] = '\0';
    }
    return timeString;
}

char *getTimeofDay() // Get the current time of day (Good morning/Good Afternoon).
{
    static char dayString[16];
    time_t t = time(NULL);
    struct tm tm = *localtime(&t);

    if (tm.tm_hour < 12)
    {
        strcpy(dayString, "Good morning,");
    }
    else
    {
        strcpy(dayString, "Good afternoon,");
    }
    return dayString;
}

void viewRegister() // Print the new username and encrypted password to account.txt.
{
    FILE *accfile;
    char confirmpassword[30];
    system("cls");
password:
    printf("\nEnter a new password to register as %s: ", user.username);
    scanf(" %s", user.password);
    system("cls");
    printf("Enter the password again: ", user.username);
    scanf(" %s", confirmpassword);
    if (strcmp(user.password, confirmpassword) != 0)
    {
        printf("Password does not match. Please try again.\n");
        goto password;
    }
    printf("\nProcessing..\n");
    encryptPassword();
    accfile = fopen("account.txt", "a");
    fprintf_s(accfile, "%s %s\n", user.username, user.password);
    fclose(accfile);
    sleep(1);
    system("cls");
    strcpy(name, user.username);
    printf("Register successful.\n\n");
    printf("Welcome, %s!\n", name);
    printf("Logging you in");
    loggedin = 1;
    for (int i = 0; i < 3; i++)
    {
        printf(".");
        usleep(600000);
    }
    system("cls");
    return;
}

void savePurchase(float sum, int dis, float cash, char *currentTime[30], int option) // Print the receipt to the database.
{
    char method[10];
    char displaysugar[30][5];
    switch (option)
    {
    case 1:
        strcpy(method, "Cash");
        break;
    case 2:
        strcpy(method, "Credit Card");
        break;
    case 3:
        strcpy(method, "Wallet");
        break;
    default:
        break;
    }

    FILE *hisfile;
    hisfile = fopen("history.txt", "a");
    fprintf_s(hisfile, "[%s] Customer : %s |", currentTime, name);
    for (int i = 0; i < cartcount; i++)
    {
        sprintf(displaysugar[i], "%.2f%%", cart[i].sugar); // Convert cart[i].sugar float to string.
        fprintf_s(hisfile, " %s %s %s x%d $%.2f", cart[i].item, cart[i].size, displaysugar[i], cart[cartcount].qty, cart[i].price);
        if (i == cartcount)
        {
            break;
        }
        fprintf(hisfile, ",");
    }
    fprintf_s(hisfile, " | Total=$%.2f, Discount=%d%%, Final Price=%.2f$, Paid=$%.2f, Change=$%.2f | Paid with %s\n", sum, dis, sum - (sum * dis) / 100, cash, cash - (sum - (sum * dis) / 100), method);
    fclose(hisfile);
}

void viewLogin() // Login/Register
{
    system("cls");
    printf("Account log in/Register.\n");
    printf("Enter username: ");
    scanf(" %s", user.username);
    updateAccount();

    int found = 0;
    int number = 0;
    for (int i = 0; i < 30; i++)
    {
        if (strcmp(data[i].username, user.username) == 0)
        {
            found = 1;
            number = i;
            break;
        }
    }
    if (found == 1)
    {
        int attempt = 0;
    password:
        if (attempt > 2)
        {
            printf("Too many failed attempts. Try again later.");
            sleep(3);
            system("cls");
            return;
        }
        printf("Enter password: ");
        scanf(" %s", user.password);
        encryptPassword();
        if (strcmp(data[number].password, user.password) == 0)
        {
            loggedin = 1;
        }
        if (loggedin == 1)
        {
            system("cls");
            attempt = 0;
            strcpy(name, user.username);
            printf("Log in successful.\n\n");
            printf("Welcome back, %s!\n", name);
            printf("Redirecting");
            for (int i = 0; i < 3; i++)
            {
                printf(".");
                usleep(600000);
            }
            system("cls");
            return;
        }
        else
        {
            attempt++;
            printf("\nWrong password. please try again. (%d time", attempt);
            if (attempt == 1)
            {
                printf(")\n");
            }
            else
            {
                printf("s)\n");
            }
            goto password;
        }
    }
    else
    {
        int option;
        printf("Username not found! Would you like to register?\n\n");
        sleep(1);
        printf("1. Retry Username.\n");
        printf("2. Register Username.\n");
        printf("3. Go back to Home.\n");
        printf("Enter a Number: ");
        scanf(" %d", &option);
        switch (option)
        {
        case 1:
            viewLogin();
            return;
        case 2:
            viewRegister();
            return;
        default:
            return;
        }
    }
}

void viewLogout()
{
    char logoutopt;
    printf("Account log out.\n\n");
    printf("Are you sure? (y/n)\n");
    scanf("\n%c", &logoutopt);
    if (logoutopt == 'y')
    {
        loggedin = 0;
        strcpy(name, "Guest");
        printf("Logged out successful.");
        sleep(2);
        system("cls");
        return;
    }
    else
    {
        printf("Log out cancelled.");
        sleep(2);
        return;
    }
}

void viewMenu()
{
    updateMenu();
    printf("   Menu                       Small   Medium  Large\n");
    for (int i = 0; i < menucount; i++)
    {
        int dots = 25 - strlen(menu[i].item);
        printf("%d  %s ", menu[i].id, menu[i].item);
        for (int j = 0; j < dots; j++)
        {
            printf(".");
        }
        printf(" $%.2f   $%.2f   $%.2f\n", menu[i].small, menu[i].medium, menu[i].large);
    }
}

float printCart()
{
    char displaysugar[50][5];
    float totalprice = 0;
    printf("Num                           Size    Sugar   Qty  Price \n");
    for (int i = 0; i < cartcount; i++)
    {
        int dots = 25 - strlen(cart[i].item);
        sprintf(displaysugar[i], "%.2f%%", cart[i].sugar);
        printf("%d  %s ", i + 1, cart[i].item);
        for (int j = 0; j < dots; j++)
        {
            printf(".");
        }
        printf(" %-7s %-7s %-4d $%.2f\n", cart[i].size, displaysugar[i], cart[i].qty, cart[i].price);
        totalprice = totalprice + cart[i].price;
    }
    return totalprice;
}

void deleteData() // For deleting a specific row of data.
{
    int toRemove;
    system("cls");
    printf("Discard an Item.\n\n");
    printCart();
    printf("\nEnter the ID if the item you want to remove (0 to return): ");
    scanf(" %d", &toRemove);
    if (toRemove < 0 || toRemove > cartcount)
    {
        system("cls");
        printf("\nInvalid ID.\n");
        sleep(1);
        return;
    }
    else if (toRemove == 0)
    {
        return;
    }
    for (int i = toRemove - 1; i < cartcount; i++)
    {
        cart[i] = cart[i + 1];
    }
    cartcount--;
    printf("\nItem '%d' successfully removed from cart.\n", toRemove);
    sleep(1);
}

void viewCheckout()
{
    system("cls");
    FILE *historyfile;
    int option;
    float cash = 0;
    float payment;
    int dis;
    float change;
    if (loggedin == 0)
    {
        printf("You need to be logged in to checkout.\n");
        sleep(2);
        return;
    }
    printf("Checkout.\n\n");
    printf("Your cart:\n\m");
    float sum = printCart();
    if (sum >= 1 && sum <= 5)
    {
        dis = 0;
    }
    else if (sum > 5 && sum <= 10)
    {
        dis = 5;
    }
    else if (sum > 10 && sum <= 20)
    {
        dis = 10;
    }
    else
    {
        dis = 15;
    }
    payment = sum - (sum * dis) / 100;
    printf("                                      Total    $%.2f \n", sum);
    printf("                                   Discount    %d%% \n\n", dis);
    printf("                                Final Total    $%.2f \n\n", payment);
    printf("Select a payment method:\n");
    printf("1. Cash\n");
    printf("2. Credit Card. (coming soon!)\n"); // Kru said these options are not avalible for now.
    printf("3. Wallet. (coming soon!)\n");
    printf("4. Go back to home.\n");
option:
    printf("Enter a number: ");
    scanf(" %d", &option);
    switch (option)
    {
    case 1:
        printf("Cash Payment.\n\n");
        while (cash < sum)
        {
            printf("Enter an amount to pay: \n");
            scanf(" %f", &cash);
            if (cash >= payment)
            {
                break;
            }
            printf("Insufficient fund.\n");
        }
        printf("Please wait..");
        sleep(2);
        system("cls");
        char *currentTime = getCurrentTime();
        printf("               Purchase Complete.\n");
        printf("Your receipt:\n");
        printf("Store:                                        Sthsth\n");
        printf("Date:                       %-10s\n\n", currentTime);
        printCart();
        printf("                                      Total    $%.2f\n", sum);
        printf("                                   Discount    %d%% \n\n", dis);
        printf("                                Final Total    $%.2f\n", payment);
        printf("                                       Paid    $%.2f \n", cash);
        change = cash - payment;
        printf("                                     Change    $%.2f \n\n", change);
        savePurchase(sum, dis, cash, currentTime, option);
        cartcount = 0;
        memset(cart, '\0', sizeof(cart));
        printf("1. Go back to home.\n");
        printf("2. Exit.\n");
        printf("Enter a number: ");
        scanf(" %d", &option);
        switch (option)
        {
        case 2:
            exit(0);
        default:
            return;
        }
        break;
    case 2:
    case 3:
        printf("It literally said coming soon right there.\n");
        sleep(2);
        goto option;
    default:
        break;
    }
}

void viewCart()
{
    int option;
    system("cls");
    if (cartcount == 0)
    {
        printf("No items in cart.\n");
        printf("1. Browse a drink.\n");
        printf("2. Go back to Home.\n");
        printf("Enter a number: \n");
        scanf(" %d", &option);
        switch (option)
        {
        case 1:
            viewOrder();
            return;
        default:
            return;
        }
    }
    printf("Your cart:\n");
    float payment = printCart();
    printf("\n                                        Payment    $%.2f \n", payment);
    printf("1. Discard an item.\n");
    printf("2. Clear cart.\n");
    printf("3. Order more.\n");
    printf("4. Checkout.\n");
    printf("5. Go back to Home.\n");
    printf("Enter a number: ");
    scanf(" %d", &option);
    switch (option)
    {
    case 1:
        deleteData();
        return;
    case 2:
        memset(cart, '\0', sizeof(cart));
        cartcount = 0;
        printf("Cart successfully cleared.\n");
        sleep(2);
        return;
    case 3:
        viewOrder();
        return;
    case 4:
        viewCheckout();
        return;
    default:
        return;
    }
}

void viewOrder()
{
    int option;
    int found = 100;
    int size;
    system("cls");
    printf("Order a Drink.\n\n");
    viewMenu();
    printf("\n");
    printf("Enter an item id to add to cart. (number) (0 to exit)\n");
    scanf(" %d", &option);
    switch (option)
    {
    case 0:
        printf("Order cancelled.");
        sleep(1);
        return;
    default:

        for (int i = 0; i < menucount; i++)
        {
            if (option == menu[i].id)
            {
                found = i;
                break;
            }
        }
        if (found != 100)
        {
            int size;
            float sugar;
            system("cls");
            printf("Item found.");
            printf("                   Small   Medium  Large\n");
            int dots = 25 - strlen(menu[found].item);
            printf("%d  %s ", menu[found].id, menu[found].item);
            for (int j = 0; j < dots; j++)
            {
                printf(".");
            }
            printf(" $%.2f   $%.2f   $%.2f\n", menu[found].small, menu[found].medium, menu[found].large);
        size:
            printf("\nChoose the size.\n");
            printf("1. Small.\n");
            printf("2. Medium.\n");
            printf("3. Large.\n");
            printf("Enter a Number: ");
            scanf(" %d", &size);
            if (size < 1 || size > 3)
            {
                printf("Invalid size selected. Try again.");
                goto size;
            }
            printf("Enter sugar level: ");
            scanf(" %f", &sugar);
            cart[cartcount].id = menu[found].id;
            while (cart[cartcount].qty < 1 || cart[cartcount].qty > 10)
            {
                printf("Enter the quantity from 1 to 10: ");
                scanf(" %d", &cart[cartcount].qty);
            }
            strcpy(cart[cartcount].item, menu[found].item);
            switch (size)
            {
            case 1:
                cart[cartcount].price = cart[cartcount].qty * menu[found].small;
                strcpy(cart[cartcount].size, "Small");
                break;
            case 2:
                cart[cartcount].price = cart[cartcount].qty * menu[found].medium;
                strcpy(cart[cartcount].size, "Medium");
                break;
            case 3:
                cart[cartcount].price = cart[cartcount].qty * menu[found].large;
                strcpy(cart[cartcount].size, "Large");
                break;
            default:
                break;
            }
            printf("Please wait..");
            sleep(1);
            cart[cartcount].sugar = sugar;
            system("cls");
            printf("Item successfully added to cart. (%d item", cartcount + 1);
            if (cartcount == 0)
            {
                printf(" in cart)\n\n");
            }
            else
            {
                printf("s in cart)\n\n");
            }
            char displaysugar[5];
            sprintf(displaysugar, "%.2f%%", cart[cartcount].sugar);
            printf("ID                            Size    Sugar   Qty  Price \n");
            int dots2 = 25 - strlen(cart[cartcount].item);
            printf("%d  %s ", cart[cartcount].id, cart[cartcount].item);
            for (int j = 0; j < dots2; j++)
            {
                printf(".");
            }
            printf(" %-7s %-7s %-5d $%.2f\n", cart[cartcount].size, displaysugar, cart[cartcount].qty, cart[cartcount].price);
            cartcount++;
            printf("\n1. View cart.\n");
            printf("2. Browse more.\n");
            printf("3. Checkout.\n");
            printf("4. Home.\n");
            printf("\nEnter a number: ");
            scanf(" %d", &option);
            switch (option)
            {
            case 1:
                viewCart();
                return;
            case 2:
                viewOrder();
                return;
            case 3:
                viewCheckout();
                return;
            default:
                return;
            }
        }
        else
        {
            printf("Failed to add item.\n");
            sleep(2);
            return;
        }
    }
}

int main()
{
    system("cls");
    int option;
home:
    system("cls");
    char *TimeofDay = getTimeofDay();
    printf("Welcome to Sthsth Cafe.\n\n");
    printf("%s %s! ", TimeofDay, name);

    if (loggedin == 0)
    {
        printf("(not logged in)\n\n");
    }
    else
    {
        printf("\n\n");
    }
    printf("1. Order a drink.\n");
    printf("2. View cart. ");
    if (cartcount == 0)
    {
        printf("\n");
    }
    else
    {
        printf("(%d)\n", cartcount);
    }
    if (loggedin == 0)
    {
        printf("0. Log in/Register.\n");
    }
    else
    {
        printf("0. Log out.\n");
    }
    printf("\nEnter a number: ");
    scanf(" %d", &option);
    system("cls");
    switch (option)
    {
    case 0:
        if (loggedin == 3)
        {
            viewLogin();
        }
        else
        {
            viewLogout();
        }
        memset(user.username, '\0', sizeof(user.username));
        memset(user.password, '\0', sizeof(user.password));
        goto home;
    case 1:
        viewOrder();
        goto home;
    case 2:
        viewCart();
        goto home;
    }
    return 0;
}