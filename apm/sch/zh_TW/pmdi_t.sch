/* 
================================================================================
檔案代號:pmdi_t
檔案名稱:核價單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmdi_t
(
pmdient       number(5)      ,/* 企業編號 */
pmdisite       varchar2(10)      ,/* 營運據點 */
pmdidocno       varchar2(20)      ,/* 核價單號 */
pmdidocdt       date      ,/* 單據日期 */
pmdi001       varchar2(1)      ,/* 委外否 */
pmdi002       varchar2(20)      ,/* 申請人員 */
pmdi003       varchar2(10)      ,/* 申請部門 */
pmdi004       varchar2(10)      ,/* 核價供應商 */
pmdi005       varchar2(10)      ,/* 幣別 */
pmdi006       varchar2(10)      ,/* 稅別 */
pmdi007       number(5,2)      ,/* 稅率 */
pmdi008       varchar2(1)      ,/* 單價含稅否 */
pmdi009       varchar2(10)      ,/* 付款條件 */
pmdi010       varchar2(1)      ,/* 限定付款條件否 */
pmdi011       varchar2(10)      ,/* 交易條件 */
pmdi012       varchar2(1)      ,/* 限定交易條件否 */
pmdi013       varchar2(10)      ,/* 幣別選擇 */
pmdi014       varchar2(10)      ,/* 核決內容 */
pmdi015       date      ,/* 生效日期 */
pmdi016       date      ,/* 失效日期 */
pmdi017       varchar2(10)      ,/* 核價對象管制 */
pmdi018       varchar2(10)      ,/* 核價使用管制 */
pmdi019       varchar2(10)      ,/* 採購通路 */
pmdi020       varchar2(1)      ,/* 限定採購通路 */
pmdi030       varchar2(255)      ,/* 備註 */
pmdi031       varchar2(1)      ,/* 限定幣別 */
pmdi032       varchar2(1)      ,/* 限定稅別 */
pmdiownid       varchar2(20)      ,/* 資料所有者 */
pmdiowndp       varchar2(10)      ,/* 資料所屬部門 */
pmdicrtid       varchar2(20)      ,/* 資料建立者 */
pmdicrtdp       varchar2(10)      ,/* 資料建立部門 */
pmdicrtdt       timestamp(0)      ,/* 資料創建日 */
pmdimodid       varchar2(20)      ,/* 資料修改者 */
pmdimoddt       timestamp(0)      ,/* 最近修改日 */
pmdicnfid       varchar2(20)      ,/* 資料確認者 */
pmdicnfdt       timestamp(0)      ,/* 資料確認日 */
pmdipstid       varchar2(20)      ,/* 資料過帳者 */
pmdipstdt       timestamp(0)      ,/* 資料過帳日 */
pmdistus       varchar2(10)      ,/* 狀態碼 */
pmdiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmdi033       varchar2(10)      ,/* 整合來源 */
pmdi034       varchar2(20)      /* 整合單號 */
);
alter table pmdi_t add constraint pmdi_pk primary key (pmdient,pmdidocno) enable validate;

create unique index pmdi_pk on pmdi_t (pmdient,pmdidocno);

grant select on pmdi_t to tiptop;
grant update on pmdi_t to tiptop;
grant delete on pmdi_t to tiptop;
grant insert on pmdi_t to tiptop;

exit;
