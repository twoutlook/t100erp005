/* 
================================================================================
檔案代號:stdi_t
檔案名稱:市場活動費用報銷
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stdi_t
(
stdient       number(5)      ,/* 企業編號 */
stdiunit       varchar2(10)      ,/* 應用組織 */
stdisite       varchar2(10)      ,/* 營運據點 */
stdidocno       varchar2(20)      ,/* 單據編號 */
stdidocdt       date      ,/* 單據日期 */
stdi001       varchar2(20)      ,/* 申請單號 */
stdi002       varchar2(30)      ,/* 活動計劃 */
stdi003       varchar2(10)      ,/* 檔期類型 */
stdi004       varchar2(10)      ,/* 活動等級 */
stdi005       varchar2(20)      ,/* 申請人員 */
stdi006       varchar2(10)      ,/* 部門編號 */
stdi007       date      ,/* 開始日期 */
stdi008       date      ,/* 結束日期 */
stdi009       varchar2(20)      ,/* 合約編號 */
stdi010       varchar2(10)      ,/* 經銷商編號 */
stdi011       varchar2(10)      ,/* 幣別 */
stdi012       varchar2(10)      ,/* 稅別 */
stdistus       varchar2(10)      ,/* 狀態碼 */
stdiownid       varchar2(20)      ,/* 資料所有者 */
stdiowndp       varchar2(10)      ,/* 資料所屬部門 */
stdicrtid       varchar2(20)      ,/* 資料建立者 */
stdicrtdp       varchar2(10)      ,/* 資料建立部門 */
stdicrtdt       timestamp(0)      ,/* 資料創建日 */
stdimodid       varchar2(20)      ,/* 資料修改者 */
stdimoddt       timestamp(0)      ,/* 最近修改日 */
stdicnfid       varchar2(20)      ,/* 資料確認者 */
stdicnfdt       timestamp(0)      ,/* 資料確認日 */
stdiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stdiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stdiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stdiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stdiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stdiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stdiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stdiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stdiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stdiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stdiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stdiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stdiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stdiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stdiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stdiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stdiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stdiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stdiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stdiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stdiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stdiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stdiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stdiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stdiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stdiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stdiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stdiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stdiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stdiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stdi_t add constraint stdi_pk primary key (stdient,stdidocno) enable validate;

create unique index stdi_pk on stdi_t (stdient,stdidocno);

grant select on stdi_t to tiptop;
grant update on stdi_t to tiptop;
grant delete on stdi_t to tiptop;
grant insert on stdi_t to tiptop;

exit;
