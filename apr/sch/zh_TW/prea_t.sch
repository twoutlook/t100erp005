/* 
================================================================================
檔案代號:prea_t
檔案名稱:促銷談判條件單頭資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prea_t
(
preaent       number(5)      ,/* 企業編號 */
preaunit       varchar2(10)      ,/* 制定組織 */
preasite       varchar2(10)      ,/* 營運組織 */
preadocno       varchar2(20)      ,/* 促銷談判單號 */
preadocdt       date      ,/* 申請日期 */
preaacti       varchar2(1)      ,/* 資料有效 */
preastus       varchar2(10)      ,/* 狀態碼 */
prea000       varchar2(10)      ,/* 作業方式 */
prea001       varchar2(20)      ,/* 規則編號 */
prea002       varchar2(10)      ,/* 版本 */
prea003       varchar2(30)      ,/* 促銷方案編號 */
prea004       varchar2(10)      ,/* 促銷方式 */
prea005       varchar2(10)      ,/* 換贈對象 */
prea006       varchar2(10)      ,/* 換贈編號 */
prea007       varchar2(30)      ,/* 活動計劃 */
prea008       varchar2(10)      ,/* 活動類型 */
prea009       varchar2(10)      ,/* 檔期類型 */
prea010       varchar2(10)      ,/* 活動等級 */
prea011       varchar2(20)      ,/* 申請人員 */
prea012       varchar2(10)      ,/* 申請部門 */
prea013       varchar2(1)      ,/* 日期高階設定 */
prea014       date      ,/* 發佈日期 */
prea015       varchar2(8)      ,/* 釋出時間 */
preaownid       varchar2(20)      ,/* 資料所屬者 */
preaowndp       varchar2(10)      ,/* 資料所有部門 */
preacrtid       varchar2(20)      ,/* 資料建立者 */
preacrtdp       varchar2(10)      ,/* 資料建立部門 */
preacrtdt       timestamp(0)      ,/* 資料創建日 */
preamodid       varchar2(20)      ,/* 資料修改者 */
preamoddt       timestamp(0)      ,/* 最近修改日 */
preacnfid       varchar2(20)      ,/* 資料確認者 */
preacnfdt       timestamp(0)      ,/* 資料確認日 */
preapstid       varchar2(20)      ,/* 資料過帳者 */
preapstdt       timestamp(0)      ,/* 資料過賬日 */
prea050       varchar2(1)      ,/* 相同基數取最低 */
prea051       varchar2(10)      ,/* 主題分類 */
prea052       varchar2(10)      /* 促銷類型 */
);
alter table prea_t add constraint prea_pk primary key (preaent,preadocno) enable validate;

create unique index prea_pk on prea_t (preaent,preadocno);

grant select on prea_t to tiptop;
grant update on prea_t to tiptop;
grant delete on prea_t to tiptop;
grant insert on prea_t to tiptop;

exit;
