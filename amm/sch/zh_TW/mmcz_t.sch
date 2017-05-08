/* 
================================================================================
檔案代號:mmcz_t
檔案名稱:會員等級變更統計條件資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmcz_t
(
mmczent       number(5)      ,/* 企業編號 */
mmczunit       varchar2(10)      ,/* 應用組織 */
mmczsite       varchar2(10)      ,/* 營運據點 */
mmczdocno       varchar2(20)      ,/* 單號 */
mmcz001       varchar2(30)      ,/* 會員編號 */
mmcz002       varchar2(10)      ,/* 統計條件 */
mmcz003       number(15,3)      ,/* 統計值 */
mmczud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmczud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmczud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmczud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmczud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmczud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmczud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmczud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmczud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmczud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmczud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmczud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmczud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmczud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmczud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmczud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmczud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmczud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmczud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmczud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmczud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmczud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmczud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmczud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmczud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmczud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmczud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmczud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmczud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmczud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcz_t add constraint mmcz_pk primary key (mmczent,mmczdocno,mmcz001,mmcz002) enable validate;

create unique index mmcz_pk on mmcz_t (mmczent,mmczdocno,mmcz001,mmcz002);

grant select on mmcz_t to tiptop;
grant update on mmcz_t to tiptop;
grant delete on mmcz_t to tiptop;
grant insert on mmcz_t to tiptop;

exit;
