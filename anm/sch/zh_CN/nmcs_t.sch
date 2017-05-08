/* 
================================================================================
檔案代號:nmcs_t
檔案名稱:資金計劃變更主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:Y
============.========================.==========================================
 */
create table nmcs_t
(
nmcsent       number(5)      ,/* 企業編號 */
nmcsdocno       varchar2(20)      ,/* 計劃編製單號 */
nmcsdocdt       date      ,/* 變更日期 */
nmcs001       number(5,0)      ,/* 變更版本 */
nmcs002       varchar2(10)      ,/* 變更單位 */
nmcsstus       varchar2(1)      ,/* 狀態碼 */
nmcsownid       varchar2(20)      ,/* 資料所有者 */
nmcsowndp       varchar2(10)      ,/* 資料所屬部門 */
nmcscrtid       varchar2(20)      ,/* 資料建立者 */
nmcscrtdp       varchar2(10)      ,/* 資料建立部門 */
nmcscrtdt       timestamp(0)      ,/* 資料創建日 */
nmcsmodid       varchar2(20)      ,/* 資料修改者 */
nmcsmoddt       timestamp(0)      ,/* 最近修改日 */
nmcscnfid       varchar2(20)      ,/* 資料確認者 */
nmcscnfdt       timestamp(0)      ,/* 資料確認日 */
nmcsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmcsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmcsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmcsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmcsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmcsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmcsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmcsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmcsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmcsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmcsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmcsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmcsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmcsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmcsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmcsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmcsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmcsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmcsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmcsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmcsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmcsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmcsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmcsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmcsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmcsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmcsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmcsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmcsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmcsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmcs_t add constraint nmcs_pk primary key (nmcsent,nmcsdocno,nmcs001) enable validate;

create unique index nmcs_pk on nmcs_t (nmcsent,nmcsdocno,nmcs001);

grant select on nmcs_t to tiptop;
grant update on nmcs_t to tiptop;
grant delete on nmcs_t to tiptop;
grant insert on nmcs_t to tiptop;

exit;
