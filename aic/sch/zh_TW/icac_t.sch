/* 
================================================================================
檔案代號:icac_t
檔案名稱:多角貿易單據別設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table icac_t
(
icacent       number(5)      ,/* 企業編號 */
icacsite       varchar2(10)      ,/* 營運據點 */
icac001       varchar2(10)      ,/* 流程代碼 */
icac002       number(5,0)      ,/* 站別 */
icac003       varchar2(5)      ,/* 訂單單別 */
icac004       varchar2(5)      ,/* 出貨通知單單別 */
icac005       varchar2(5)      ,/* 包裝單單別 */
icac006       varchar2(5)      ,/* Invoice */
icac007       varchar2(5)      ,/* 出貨單單別 */
icac008       varchar2(5)      ,/* 出貨簽收單別 */
icac009       varchar2(5)      ,/* 銷退單別 */
icac010       varchar2(5)      ,/* 採購單單別 */
icac011       varchar2(5)      ,/* 無採購收貨入庫單別 */
icac012       varchar2(5)      ,/* 收貨入庫單別 */
icac013       varchar2(5)      ,/* 倉退單別 */
icac014       varchar2(5)      ,/* 委外工單單別 */
icacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
icacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
icacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
icacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
icacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
icacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
icacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
icacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
icacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
icacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
icacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
icacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
icacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
icacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
icacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
icacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
icacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
icacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
icacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
icacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
icacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
icacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
icacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
icacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
icacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
icacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
icacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
icacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
icacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
icacud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
icac015       varchar2(5)      /* 無訂單出貨單單別 */
);
alter table icac_t add constraint icac_pk primary key (icacent,icac001,icac002) enable validate;

create unique index icac_pk on icac_t (icacent,icac001,icac002);

grant select on icac_t to tiptop;
grant update on icac_t to tiptop;
grant delete on icac_t to tiptop;
grant insert on icac_t to tiptop;

exit;
