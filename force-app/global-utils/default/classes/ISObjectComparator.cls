/**
 * The apex-lang `ISObjectComparator` interface. The classes in this group have 
 * been randomly gathered from various resources simply to demonstrate ApexDox VS Code's
 * multi-source directory feature aimed at Salesforce-DX projects which may have a `main`
 * folder and multipke feature directories. See {@link ArrayUtils.qsort[4]}.
 * 
 * <br><br>
 * 
 * This code is part of the 'apex-lang' open source project avaiable at:
 * 
 * {@link http://code.google.com/p/apex-lang/}.
 * 
 * This code is licensed under the Apache License, Version 2.0. You may obtain a 
 * copy of the License at:
 * 
 * {@link http://www.apache.org/licenses/LICENSE-2.0}.
 * 
 * @author Richard Vanhook
 * @since Dec 28, 2008
 * @group Global Utils
 * @see ArrayUtils.qsort[4]
 */
global interface ISObjectComparator{
    Integer compare(SObject record1, SObject record2);
}