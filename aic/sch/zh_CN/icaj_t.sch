/* 
================================================================================
檔案代號:icaj_t
檔案名稱:訂單分配明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table icaj_t
(
icajent       number(5)      ,/* 企業編號 */
icajsite       varchar2(10)      ,/* 營運據點 */
icaj001       varchar2(20)      ,/* 訂單單號 */
icaj002       number(10,0)      ,/* 訂單項次 */
icaj003       number(10,0)      ,/* 訂單項序 */
icaj004       number(10,0)      ,/* 訂單分批序 */
icaj005       number(20,6)      ,/* 分配量 */
icaj006       varchar2(10)      ,/* 多角流程代碼 */
icaj007       varchar2(5)      ,/* 預設採購單單別 */
icaj008       varchar2(20)      ,/* 單據編號 */
icaj009       number(10,0)      ,/* 單據項次 */
icaj010       number(10,0)      ,/* 單據項序 */
icaj011       number(10,0)      ,/* 單據分批序 */
icajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
icajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
icajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
icajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
icajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
icajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
icajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
icajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
icajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
icajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
icajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
icajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
icajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
icajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
icajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
icajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
icajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
icajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
icajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
icajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
icajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
icajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
icajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
icajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
icajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
icajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
icajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
icajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
icajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
icajud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table icaj_t add constraint icaj_pk primary key (icajent,icaj001,icaj002,icaj003,icaj004,icaj006) enable validate;


grant select on icaj_t to tiptop;
grant update on icaj_t to tiptop;
grant delete on icaj_t to tiptop;
grant insert on icaj_t to tiptop;

exit;
