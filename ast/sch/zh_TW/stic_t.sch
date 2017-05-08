/* 
================================================================================
檔案代號:stic_t
檔案名稱:預租協議單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stic_t
(
sticent       number(5)      ,/* 企業編號 */
sticsite       varchar2(10)      ,/* 營運據點 */
sticunit       varchar2(10)      ,/* 應用組織 */
sticdocno       varchar2(20)      ,/* 單據編號 */
sticdocdt       date      ,/* 單據日期 */
stic001       varchar2(10)      ,/* 預租類型 */
stic002       varchar2(10)      ,/* 商戶編號 */
stic003       varchar2(80)      ,/* 商戶連絡電話 */
stic004       date      ,/* 預租開始日期 */
stic005       date      ,/* 預租結束日期 */
stic006       varchar2(20)      ,/* 原合約編號 */
stic007       varchar2(20)      ,/* 新合約編號 */
stic008       date      ,/* 合約開始日期 */
stic009       date      ,/* 合約結束日期 */
stic010       varchar2(20)      ,/* 鋪位編號 */
stic011       number(5,0)      ,/* 鋪位版本 */
stic012       varchar2(10)      ,/* 樓棟編號 */
stic013       varchar2(10)      ,/* 樓層編號 */
stic014       varchar2(10)      ,/* 品類編號 */
stic015       varchar2(10)      ,/* 主品牌 */
stic016       varchar2(10)      ,/* 收銀方式 */
stic017       varchar2(20)      ,/* 費用單號 */
stic018       varchar2(10)      ,/* 費用編號 */
stic019       number(20,6)      ,/* 預收金額 */
stic020       varchar2(20)      ,/* 業務人員 */
stic021       varchar2(10)      ,/* 業務部門 */
stic022       date      ,/* 終止日期 */
stic023       varchar2(20)      ,/* 終止人員 */
stic024       varchar2(10)      ,/* 終止部門 */
stic025       varchar2(80)      ,/* 備註 */
sticstus       varchar2(10)      ,/* 狀態碼 */
sticownid       varchar2(20)      ,/* 資料所有者 */
sticowndp       varchar2(10)      ,/* 資料所屬部門 */
sticcrtid       varchar2(20)      ,/* 資料建立者 */
sticcrtdp       varchar2(10)      ,/* 資料建立部門 */
sticcrtdt       timestamp(0)      ,/* 資料創建日 */
sticmodid       varchar2(20)      ,/* 資料修改者 */
sticmoddt       timestamp(0)      ,/* 最近修改日 */
sticcnfid       varchar2(20)      ,/* 資料確認者 */
sticcnfdt       timestamp(0)      ,/* 資料確認日 */
sticud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sticud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sticud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sticud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sticud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sticud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sticud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sticud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sticud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sticud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sticud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sticud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sticud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sticud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sticud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sticud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sticud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sticud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sticud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sticud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sticud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sticud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sticud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sticud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sticud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sticud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sticud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sticud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sticud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sticud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stic_t add constraint stic_pk primary key (sticent,sticdocno) enable validate;

create unique index stic_pk on stic_t (sticent,sticdocno);

grant select on stic_t to tiptop;
grant update on stic_t to tiptop;
grant delete on stic_t to tiptop;
grant insert on stic_t to tiptop;

exit;
