//
//  main.m
//  iReSign
//
//  Created by Maciej Swic on 2011-05-16.
//  Copyright (c) 2011 Maciej Swic, Licensed under the MIT License.
//  See README.md for details
//

#import <Cocoa/Cocoa.h>
#import "iReSignAppDelegate.h"

int usage() {
    
    char* helpstr = "iResignShell Re-signs an IPA file.\n"
    "Usage: iResignShell [-h]\n"
    "Usage: iResignShell [options] -a app -m mobileprovision -e entitlements -c certificate"
    "\n"
    "mandatory arguments:\n"
    "    -a <ipa or xcarchive>      app\n"
    "    -c <cer_name>              certificate：iPhone Developer: xxxx\n"
    "    -m <mobileprovision>       mobileprovision\n\n"
    "optional arguments:\n"
    "    -e <Entitlements.plist>    Entitlements.plist\n"
    "    -b <new BundleID>          optionalnew App ID\n"
    "    -o <output file/path>      output\n"
    
    "Usage  examples :\n"
    
    "    iResignShell -h\n"
    
    "    iResignShell -a myApp.ipa -c \"iPhone Distribution: Developer\" -m Dev.mobileprovision -o out.ipa -e entitlements.plist\n";
    
    
    printf("%s", helpstr);
    return 0;
}


int main(int argc, char *argv[])
{
    if(argc>1)
    {
        int hflag = 0;
        char *bvalue = "";
        char *cvalue = NULL;
        char *ovalue = "";
        char *mvalue = NULL;
        char *avalue = NULL;
        char *evalue = "";
        int index;
        int c;
        
        opterr = 0;
        
        while ((c = getopt (argc, argv, "hb:o:a:c:e:m:")) != -1)
            switch (c)
        {
            case 'b':
                bvalue = optarg;
                break;
            case 'a':
                avalue = optarg;
                break;
            case 'h':
                hflag = 1;
                break;
            case 'o':
                ovalue = optarg;
                break;
            case 'e':
                evalue = optarg;
                break;
            case 'c':
                cvalue = optarg;
                break;
            case 'm':
                mvalue = optarg;
                break;
            case '?':
                if (optopt == 'c')
                    fprintf (stderr, "Option -%c requires an argument.\n", optopt);
                else if (isprint (optopt))
                    fprintf (stderr, "Unknown option `-%c'.\n", optopt);
                else
                    fprintf (stderr,
                             "Unknown option character `\\x%x'.\n",
                             optopt);
                return 1;
            default:
                abort ();
        }
        
        if(hflag) {
            usage();
            return 0;
        }
        
        if(avalue == NULL || cvalue == NULL || mvalue == NULL ){
            printf("Arguments -a -c -m are mandatory.\n");
            return 0;
        }
        
        for (index = optind; index < argc; index++)
            printf("%s\n", argv[index]);
        
        iReSignAppDelegate* app = [[iReSignAppDelegate alloc] init];
        [app resignApp:[NSString stringWithCString:avalue encoding:NSASCIIStringEncoding] andEntitlements:[NSString stringWithCString:evalue encoding:NSASCIIStringEncoding] andBundle:[NSString stringWithCString:bvalue encoding:NSASCIIStringEncoding] andOutput:[NSString stringWithCString:ovalue encoding:NSASCIIStringEncoding] andCert:[NSString stringWithCString:cvalue encoding:NSASCIIStringEncoding] andMobileprovision:[NSString stringWithCString:mvalue encoding:NSASCIIStringEncoding]];
        
        return 0;
    }
    
    return NSApplicationMain(argc, (const char **)argv);
}
