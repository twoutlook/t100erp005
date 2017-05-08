/* 
================================================================================
檔案代號:sfdc_t
檔案名稱:發退料需求檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table sfdc_t
(
sfdcent       number(5)      ,/* 企業編號 */
sfdcsite       varchar2(10)      ,/* 營運據點 */
sfdcdocno       varchar2(20)      ,/* 發退料單號 */
sfdcseq       number(10,0)      ,/* 項次 */
sfdc001       varchar2(20)      ,/* 工單單號 */
sfdc002       number(10,0)      ,/* 工單項次 */
sfdc003       number(10,0)      ,/* 工單項序 */
sfdc004       varchar2(40)      ,/* 需求料號 */
sfdc005       varchar2(256)      ,/* 產品特徵 */
sfdc006       varchar2(10)      ,/* 單位 */
sfdc007       number(20,6)      ,/* 申請數量 */
sfdc008       number(20,6)      ,/* 實際數量 */
sfdc009       varchar2(10)      ,/* 參考單位 */
sfdc010       number(20,6)      ,/* 參考單位需求數量 */
sfdc011       number(20,6)      ,/* 參考單位實際數量 */
sfdc012       varchar2(10)      ,/* 指定庫位 */
sfdc013       varchar2(10)      ,/* 指定儲位 */
sfdc014       varchar2(30)      ,/* 指定批號 */
sfdc015       varchar2(10)      ,/* 理由碼 */
sfdc016       varchar2(30)      ,/* 庫存管理特徴 */
sfdc017       number(20,6)      ,/* 正負 */
sfdcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfdcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfdcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfdcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfdcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfdcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfdcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfdcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfdcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfdcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfdcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfdcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfdcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfdcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfdcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfdcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfdcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfdcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfdcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfdcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfdcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfdcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfdcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfdcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfdcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfdcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfdcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfdcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfdcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfdcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfdc_t add constraint sfdc_pk primary key (sfdcent,sfdcdocno,sfdcseq) enable validate;

create  index sfdc_n1 on sfdc_t (sfdcent,sfdc001,sfdc002);
create  index sfdc_n2 on sfdc_t (sfdcent,sfdcsite,sfdc001,sfdc004,sfdc005);
create unique index sfdc_pk on sfdc_t (sfdcent,sfdcdocno,sfdcseq);

grant select on sfdc_t to tiptop;
grant update on sfdc_t to tiptop;
grant delete on sfdc_t to tiptop;
grant insert on sfdc_t to tiptop;

exit;
