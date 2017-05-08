/* 
================================================================================
檔案代號:xcac_t
檔案名稱:資源標準費率檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcac_t
(
xcacent       number(5)      ,/* 企業編號 */
xcacownid       varchar2(20)      ,/* 資料所有者 */
xcacowndp       varchar2(10)      ,/* 資料所屬部門 */
xcaccrtid       varchar2(20)      ,/* 資料建立者 */
xcaccrtdp       varchar2(10)      ,/* 資料建立部門 */
xcaccrtdt       timestamp(0)      ,/* 資料創建日 */
xcacmodid       varchar2(20)      ,/* 資料修改者 */
xcacmoddt       timestamp(0)      ,/* 最近修改日 */
xcacstus       varchar2(10)      ,/* 狀態碼 */
xcacsite       varchar2(10)      ,/* 營運據點 */
xcac001       varchar2(10)      ,/* 版本 */
xcac002       varchar2(20)      ,/* 資源編碼 */
xcac003       number(10)      ,/* 成本主要素 */
xcac004       varchar2(10)      ,/* 成本次要素 */
xcac005       varchar2(10)      ,/* 幣種 */
xcac006       number(20,6)      ,/* 標準費率 */
xcacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcac_t add constraint xcac_pk primary key (xcacent,xcac001,xcac002) enable validate;

create unique index xcac_pk on xcac_t (xcacent,xcac001,xcac002);

grant select on xcac_t to tiptop;
grant update on xcac_t to tiptop;
grant delete on xcac_t to tiptop;
grant insert on xcac_t to tiptop;

exit;
