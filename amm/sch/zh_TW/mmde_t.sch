/* 
================================================================================
檔案代號:mmde_t
檔案名稱:會員卡可付款明細資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table mmde_t
(
mmdeent       number(5)      ,/* 企業編號 */
mmde001       varchar2(30)      ,/* 會員卡號 */
mmde002       number(10)      ,/* 資料類型 */
mmde003       varchar2(40)      ,/* 資料編號 */
mmde004       date      ,/* 有效日期 */
mmdeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmdeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmdeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmdeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmdeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmdeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmdeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmdeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmdeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmdeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmdeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmdeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmdeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmdeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmdeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmdeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmdeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmdeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmdeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmdeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmdeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmdeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmdeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmdeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmdeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmdeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmdeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmdeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmdeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmdeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmde_t add constraint mmde_pk primary key (mmdeent,mmde001,mmde002,mmde003,mmde004) enable validate;

create unique index mmde_pk on mmde_t (mmdeent,mmde001,mmde002,mmde003,mmde004);

grant select on mmde_t to tiptop;
grant update on mmde_t to tiptop;
grant delete on mmde_t to tiptop;
grant insert on mmde_t to tiptop;

exit;
