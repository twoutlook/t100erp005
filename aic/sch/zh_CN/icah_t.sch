/* 
================================================================================
檔案代號:icah_t
檔案名稱:多角貿易轉撥單價設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table icah_t
(
icahent       number(5)      ,/* 企業編號 */
icahsite       varchar2(10)      ,/* 營運據點 */
icah001       varchar2(10)      ,/* 流程編號 */
icah002       varchar2(10)      ,/* 來源營運據點 */
icah003       varchar2(10)      ,/* 目的營運據點 */
icah004       date      ,/* 生效日期 */
icah005       varchar2(10)      ,/* 採購幣別 */
icah006       varchar2(40)      ,/* 料件編號 */
icah007       varchar2(256)      ,/* 產品特徵 */
icah009       number(20,6)      ,/* 採購未稅單價 */
icah010       number(20,6)      ,/* 採購含稅單價 */
icahownid       varchar2(20)      ,/* 資料所有者 */
icahowndp       varchar2(10)      ,/* 資料所屬部門 */
icahcrtid       varchar2(20)      ,/* 資料建立者 */
icahcrtdp       varchar2(10)      ,/* 資料建立部門 */
icahcrtdt       timestamp(0)      ,/* 資料創建日 */
icahmodid       varchar2(20)      ,/* 資料修改者 */
icahmoddt       timestamp(0)      ,/* 最近修改日 */
icahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
icahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
icahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
icahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
icahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
icahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
icahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
icahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
icahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
icahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
icahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
icahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
icahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
icahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
icahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
icahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
icahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
icahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
icahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
icahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
icahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
icahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
icahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
icahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
icahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
icahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
icahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
icahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
icahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
icahud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
icah011       varchar2(10)      ,/* 產品分類 */
icah012       varchar2(10)      /* 系列 */
);
alter table icah_t add constraint icah_pk primary key (icahent,icah001,icah002,icah003,icah004,icah006,icah007) enable validate;

create unique index icah_pk on icah_t (icahent,icah001,icah002,icah003,icah004,icah006,icah007);

grant select on icah_t to tiptop;
grant update on icah_t to tiptop;
grant delete on icah_t to tiptop;
grant insert on icah_t to tiptop;

exit;
