/* 
================================================================================
檔案代號:sffc_t
檔案名稱:報工Check in/Check out項目檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sffc_t
(
sffcent       number(5)      ,/* 企業編號 */
sffcsite       varchar2(10)      ,/* 營運據點 */
sffcdocno       varchar2(20)      ,/* 報工單號 */
sffcseq       number(10,0)      ,/* 項次 */
sffc001       varchar2(10)      ,/* 項目 */
sffc002       varchar2(10)      ,/* 型態 */
sffc003       number(15,3)      ,/* 下限 */
sffc004       number(15,3)      ,/* 上限 */
sffc005       varchar2(80)      ,/* 預設值 */
sffc006       varchar2(1)      ,/* 必要 */
sffcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sffcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sffcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sffcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sffcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sffcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sffcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sffcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sffcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sffcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sffcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sffcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sffcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sffcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sffcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sffcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sffcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sffcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sffcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sffcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sffcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sffcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sffcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sffcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sffcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sffcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sffcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sffcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sffcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sffcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sffc_t add constraint sffc_pk primary key (sffcent,sffcdocno,sffcseq,sffc001) enable validate;

create unique index sffc_pk on sffc_t (sffcent,sffcdocno,sffcseq,sffc001);

grant select on sffc_t to tiptop;
grant update on sffc_t to tiptop;
grant delete on sffc_t to tiptop;
grant insert on sffc_t to tiptop;

exit;
