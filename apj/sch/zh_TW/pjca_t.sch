/* 
================================================================================
檔案代號:pjca_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table pjca_t
(
pjcaent       number(5)      ,/* 企業編號 */
pjcacomp       varchar2(10)      ,/* 法人組織 */
pjcald       varchar2(5)      ,/* 帳套 */
pjca001       varchar2(1)      ,/* 帳套本位幣順序 */
pjca002       varchar2(10)      ,/* 成本域(專案編號) */
pjca003       varchar2(10)      ,/* 成本計算類型 */
pjca004       number(5,0)      ,/* 年度 */
pjca005       number(5,0)      ,/* 期別 */
pjca006       number(20,6)      ,/* 本幣執行預算 */
pjca007       number(20,6)      ,/* 本幣合約金額 */
pjca021       number(20,6)      ,/* 預收工程款累計數 */
pjca008       number(20,6)      ,/* 進度比 */
pjca009       varchar2(1)      ,/* 認列方式 */
pjca010       varchar2(10)      ,/* 核算幣別 */
pjca011       number(20,6)      ,/* 認列成本-材料 */
pjca012       number(20,6)      ,/* 認列成本-包作 */
pjca013       number(20,6)      ,/* 認列成本-人工 */
pjca014       number(20,6)      ,/* 認列成本-費用 */
pjca015       number(20,6)      ,/* 認列成本-其他 */
pjca016       number(20,6)      ,/* 認列成本-虧損 */
pjca017       number(20,6)      ,/* 認列成本-合計 */
pjca018       number(20,6)      ,/* 認列收入 */
pjca019       number(20,6)      ,/* 在建利益 */
pjca020       number(20,6)      ,/* 在建損失 */
pjca902       number(20,6)      ,/* 廠內期末金額 */
pjca902a       number(20,6)      ,/* 廠內期末金額-材料 */
pjca902b       number(20,6)      ,/* 廠內期末金額-人工 */
pjca902c       number(20,6)      ,/* 廠內期末金額-加工 */
pjca902d       number(20,6)      ,/* 廠內期末金額-制費一 */
pjca902e       number(20,6)      ,/* 廠內期末金額-制費二 */
pjca902f       number(20,6)      ,/* 廠內期末金額-制費三 */
pjca902g       number(20,6)      ,/* 廠內期末金額-制費四 */
pjca902h       number(20,6)      ,/* 廠內期末金額-制費五 */
pjca912       number(20,6)      ,/* 在製期末金額 */
pjca912a       number(20,6)      ,/* 在製期末金額-材料 */
pjca912b       number(20,6)      ,/* 在製期末金額-人工 */
pjca912c       number(20,6)      ,/* 在製期末金額-加工 */
pjca912d       number(20,6)      ,/* 在製期末金額-制費一 */
pjca912e       number(20,6)      ,/* 在製期末金額-制費二 */
pjca912f       number(20,6)      ,/* 在製期末金額-制費三 */
pjca912g       number(20,6)      ,/* 在製期末金額-制費四 */
pjca912h       number(20,6)      ,/* 在製期末金額-制費五 */
pjca922       number(20,6)      ,/* 現場期末金額 */
pjca922a       number(20,6)      ,/* 現場期末金額-材料 */
pjca922b       number(20,6)      ,/* 現場期末金額-包作 */
pjca922c       number(20,6)      ,/* 現場期末金額-人工 */
pjca922d       number(20,6)      ,/* 現場期末金額-費用 */
pjca922e       number(20,6)      /* 現場期末成本-其他 */
);
alter table pjca_t add constraint pjca_pk primary key (pjcaent,pjcald,pjca001,pjca002,pjca003,pjca004,pjca005) enable validate;

create unique index pjca_pk on pjca_t (pjcaent,pjcald,pjca001,pjca002,pjca003,pjca004,pjca005);

grant select on pjca_t to tiptop;
grant update on pjca_t to tiptop;
grant delete on pjca_t to tiptop;
grant insert on pjca_t to tiptop;

exit;
