/* 
================================================================================
檔案代號:icad_t
檔案名稱:多角貿易其他資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table icad_t
(
icadent       number(5)      ,/* 企業編號 */
icadsite       varchar2(10)      ,/* 營運據點 */
icad001       varchar2(10)      ,/* 流程代碼 */
icad002       number(5,0)      ,/* 站別 */
icad003       varchar2(10)      ,/* 銷售分類 */
icad004       varchar2(10)      ,/* 庫位 */
icad005       varchar2(10)      ,/* 儲位 */
icad006       varchar2(10)      ,/* 出貨理由碼 */
icad007       varchar2(10)      ,/* 入庫理由碼 */
icad008       varchar2(10)      ,/* 銷退理由碼 */
icad009       varchar2(10)      ,/* 倉退理由碼 */
icad010       varchar2(10)      ,/* 調撥理由碼 */
icad011       varchar2(10)      ,/* 採購分類 */
icadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
icadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
icadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
icadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
icadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
icadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
icadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
icadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
icadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
icadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
icadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
icadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
icadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
icadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
icadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
icadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
icadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
icadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
icadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
icadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
icadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
icadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
icadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
icadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
icadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
icadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
icadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
icadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
icadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
icadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table icad_t add constraint icad_pk primary key (icadent,icad001,icad002) enable validate;

create unique index icad_pk on icad_t (icadent,icad001,icad002);

grant select on icad_t to tiptop;
grant update on icad_t to tiptop;
grant delete on icad_t to tiptop;
grant insert on icad_t to tiptop;

exit;
