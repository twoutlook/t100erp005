/* 
================================================================================
檔案代號:xmdx_t
檔案名稱:銷售合約單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table xmdx_t
(
xmdxent       number(5)      ,/* 企業編號 */
xmdxsite       varchar2(10)      ,/* 營運據點 */
xmdxdocno       varchar2(20)      ,/* 合約單號 */
xmdxdocdt       date      ,/* 單據日期 */
xmdx000       number(5,0)      ,/* 版本 */
xmdx001       varchar2(1)      ,/* 委外否 */
xmdx002       varchar2(20)      ,/* 銷售人員 */
xmdx003       varchar2(10)      ,/* 銷售部門 */
xmdx004       varchar2(10)      ,/* 客戶 */
xmdx005       varchar2(10)      ,/* 幣別 */
xmdx006       varchar2(10)      ,/* 稅別 */
xmdx007       number(5,2)      ,/* 稅率 */
xmdx008       varchar2(1)      ,/* 單價含稅否 */
xmdx009       varchar2(10)      ,/* 收款條件 */
xmdx010       varchar2(1)      ,/* 限定收款條件否 */
xmdx011       varchar2(10)      ,/* 交易條件 */
xmdx012       varchar2(1)      ,/* 限定交易條件否 */
xmdx013       varchar2(10)      ,/* 核決內容 */
xmdx014       date      ,/* 生效日期 */
xmdx015       date      ,/* 失效日期 */
xmdx016       varchar2(10)      ,/* 合約對象管制 */
xmdx017       varchar2(10)      ,/* 合約使用管制 */
xmdx018       varchar2(10)      ,/* 合約使用管制 */
xmdx019       varchar2(1)      ,/* 限定幣別 */
xmdx020       varchar2(1)      ,/* 限定稅別 */
xmdx030       varchar2(255)      ,/* 備註 */
xmdxownid       varchar2(20)      ,/* 資料所有者 */
xmdxowndp       varchar2(10)      ,/* 資料所屬部門 */
xmdxcrtid       varchar2(20)      ,/* 資料建立者 */
xmdxcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmdxcrtdt       timestamp(0)      ,/* 資料創建日 */
xmdxmodid       varchar2(20)      ,/* 資料修改者 */
xmdxmoddt       timestamp(0)      ,/* 最近修改日 */
xmdxcnfid       varchar2(20)      ,/* 資料確認者 */
xmdxcnfdt       timestamp(0)      ,/* 資料確認日 */
xmdxstus       varchar2(10)      ,/* 狀態碼 */
xmdxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmdx_t add constraint xmdx_pk primary key (xmdxent,xmdxdocno) enable validate;

create unique index xmdx_pk on xmdx_t (xmdxent,xmdxdocno);

grant select on xmdx_t to tiptop;
grant update on xmdx_t to tiptop;
grant delete on xmdx_t to tiptop;
grant insert on xmdx_t to tiptop;

exit;
