/* 
================================================================================
檔案代號:xcak_t
檔案名稱:標準成本_工藝資源檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcak_t
(
xcakent       number(5)      ,/* 企業編號 */
xcakownid       varchar2(20)      ,/* 資料所有者 */
xcakowndp       varchar2(10)      ,/* 資料所屬部門 */
xcakcrtid       varchar2(20)      ,/* 資料建立者 */
xcakcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcakcrtdt       timestamp(0)      ,/* 資料創建日 */
xcakmodid       varchar2(20)      ,/* 資料修改者 */
xcakmoddt       timestamp(0)      ,/* 最近修改日 */
xcakstus       varchar2(10)      ,/* 狀態碼 */
xcaksite       varchar2(10)      ,/* 營運據點 */
xcak001       varchar2(10)      ,/* 標準成本分類 */
xcak002       date      ,/* 生效日期 */
xcak003       date      ,/* 失效日期 */
xcak004       varchar2(40)      ,/* 製程料號 */
xcakseq1       number(10,0)      ,/* 工藝項次 */
xcakseq2       number(10,0)      ,/* 資源項次 */
xcak005       varchar2(10)      ,/* 版本 */
xcak006       varchar2(10)      ,/* 資源編號 */
xcak007       number(20,6)      ,/* 固定耗用 */
xcak008       number(20,6)      ,/* 變動耗用 */
xcak009       number(20,6)      ,/* 耗用批量 */
xcak010       varchar2(80)      ,/* 備註 */
xcakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcakud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcak_t add constraint xcak_pk primary key (xcakent,xcaksite,xcak001,xcak002,xcak003,xcak004,xcakseq1,xcakseq2) enable validate;

create unique index xcak_pk on xcak_t (xcakent,xcaksite,xcak001,xcak002,xcak003,xcak004,xcakseq1,xcakseq2);

grant select on xcak_t to tiptop;
grant update on xcak_t to tiptop;
grant delete on xcak_t to tiptop;
grant insert on xcak_t to tiptop;

exit;
