/* 
================================================================================
檔案代號:stdc_t
檔案名稱:內部結算參數流程與價格設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stdc_t
(
stdcent       number(5)      ,/* 企業編號 */
stdc001       varchar2(10)      ,/* 流程代碼 */
stdc002       number(10,0)      ,/* 順序 */
stdc003       varchar2(10)      ,/* 對象編號 */
stdc004       varchar2(10)      ,/* 價格類型 */
stdc005       number(20,6)      ,/* 價格比例 */
stdcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stdcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stdcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stdcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stdcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stdcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stdcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stdcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stdcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stdcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stdcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stdcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stdcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stdcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stdcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stdcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stdcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stdcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stdcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stdcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stdcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stdcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stdcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stdcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stdcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stdcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stdcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stdcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stdcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stdcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stdc_t add constraint stdc_pk primary key (stdcent,stdc001,stdc002) enable validate;

create unique index stdc_pk on stdc_t (stdcent,stdc001,stdc002);

grant select on stdc_t to tiptop;
grant update on stdc_t to tiptop;
grant delete on stdc_t to tiptop;
grant insert on stdc_t to tiptop;

exit;
