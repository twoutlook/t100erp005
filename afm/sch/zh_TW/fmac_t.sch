/* 
================================================================================
檔案代號:fmac_t
檔案名稱:融資合約維護檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmac_t
(
fmacent       number(5)      ,/* 企業代碼 */
fmac001       varchar2(20)      ,/* 融資合約編號 */
fmac002       varchar2(10)      ,/* 融資申請組織 */
fmac003       varchar2(15)      ,/* 合約銀行 */
fmac004       date      ,/* 核准日期 */
fmac005       date      ,/* 有效日期 */
fmac006       varchar2(10)      ,/* 合約主幣別 */
fmac007       number(20,6)      ,/* 合約總額度 */
fmac008       varchar2(1)      ,/* 額度內迴圈使用 */
fmac009       varchar2(1)      ,/* 提供擔保 */
fmac010       varchar2(1)      ,/* 擔保方式 */
fmac011       varchar2(80)      ,/* 貸款用途 */
fmacownid       varchar2(20)      ,/* 資料所有者 */
fmacowndp       varchar2(10)      ,/* 資料所有部門 */
fmaccrtid       varchar2(20)      ,/* 資料建立者 */
fmaccrtdp       varchar2(10)      ,/* 資料建立部門 */
fmaccrtdt       timestamp(0)      ,/* 資料創建日 */
fmacmodid       varchar2(20)      ,/* 資料修改者 */
fmacmoddt       timestamp(0)      ,/* 最近修改日 */
fmaccnfid       varchar2(20)      ,/* 資料確認者 */
fmaccnfdt       timestamp(0)      ,/* 資料確認日 */
fmacstus       varchar2(10)      ,/* 狀態碼 */
fmacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmac_t add constraint fmac_pk primary key (fmacent,fmac001) enable validate;

create unique index fmac_pk on fmac_t (fmacent,fmac001);

grant select on fmac_t to tiptop;
grant update on fmac_t to tiptop;
grant delete on fmac_t to tiptop;
grant insert on fmac_t to tiptop;

exit;
