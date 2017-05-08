/* 
================================================================================
檔案代號:pmdx_t
檔案名稱:採購合約單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmdx_t
(
pmdxent       number(5)      ,/* 企業編號 */
pmdxsite       varchar2(10)      ,/* 營運據點 */
pmdxdocno       varchar2(20)      ,/* 合約單號 */
pmdxdocdt       date      ,/* 單據日期 */
pmdx000       number(5,0)      ,/* 版本 */
pmdx001       varchar2(1)      ,/* 委外否 */
pmdx002       varchar2(20)      ,/* 採購人員 */
pmdx003       varchar2(10)      ,/* 採購部門 */
pmdx004       varchar2(10)      ,/* 供應商 */
pmdx005       varchar2(10)      ,/* 幣別 */
pmdx006       varchar2(10)      ,/* 稅別 */
pmdx007       number(5,2)      ,/* 稅率 */
pmdx008       varchar2(10)      ,/* 單價含稅否 */
pmdx009       varchar2(10)      ,/* 付款條件 */
pmdx010       varchar2(1)      ,/* 限定付款條件否 */
pmdx011       varchar2(10)      ,/* 交易條件 */
pmdx012       varchar2(1)      ,/* 限定交易條件否 */
pmdx013       varchar2(10)      ,/* 核決內容 */
pmdx014       date      ,/* 生效日期 */
pmdx015       date      ,/* 失效日期 */
pmdx016       varchar2(10)      ,/* 合約對象管制 */
pmdx017       varchar2(10)      ,/* 合約使用管制 */
pmdx018       varchar2(10)      ,/* 合約管制方式 */
pmdx019       varchar2(1)      ,/* 限定幣別 */
pmdx020       varchar2(1)      ,/* 限定稅別 */
pmdx030       varchar2(255)      ,/* 備註 */
pmdxownid       varchar2(20)      ,/* 資料所有者 */
pmdxowndp       varchar2(10)      ,/* 資料所屬部門 */
pmdxcrtid       varchar2(20)      ,/* 資料建立者 */
pmdxcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmdxcrtdt       timestamp(0)      ,/* 資料創建日 */
pmdxmodid       varchar2(20)      ,/* 資料修改者 */
pmdxmoddt       timestamp(0)      ,/* 最近修改日 */
pmdxcnfid       varchar2(20)      ,/* 資料確認者 */
pmdxcnfdt       timestamp(0)      ,/* 資料確認日 */
pmdxpstid       varchar2(20)      ,/* 資料過帳者 */
pmdxpstdt       timestamp(0)      ,/* 資料過帳日 */
pmdxstus       varchar2(10)      ,/* 狀態碼 */
pmdxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmdx_t add constraint pmdx_pk primary key (pmdxent,pmdxdocno) enable validate;

create unique index pmdx_pk on pmdx_t (pmdxent,pmdxdocno);

grant select on pmdx_t to tiptop;
grant update on pmdx_t to tiptop;
grant delete on pmdx_t to tiptop;
grant insert on pmdx_t to tiptop;

exit;
