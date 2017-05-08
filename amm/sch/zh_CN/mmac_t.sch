/* 
================================================================================
檔案代號:mmac_t
檔案名稱:會員基本資料申請檔-紀念日
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmac_t
(
mmacent       number(5)      ,/* 企業編號 */
mmacdocno       varchar2(20)      ,/* 單據編號 */
mmac001       varchar2(30)      ,/* 會員編號 */
mmac002       varchar2(10)      ,/* 紀念日代碼 */
mmac003       date      ,/* 紀念日期 */
mmac004       varchar2(10)      ,/* 紀念日期-年 */
mmac005       varchar2(10)      ,/* 紀念日期-月 */
mmac006       varchar2(10)      ,/* 紀念日期-日 */
mmacacti       varchar2(10)      ,/* 資料有效碼 */
mmacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmac_t add constraint mmac_pk primary key (mmacent,mmacdocno,mmac002) enable validate;

create unique index mmac_pk on mmac_t (mmacent,mmacdocno,mmac002);

grant select on mmac_t to tiptop;
grant update on mmac_t to tiptop;
grant delete on mmac_t to tiptop;
grant insert on mmac_t to tiptop;

exit;
