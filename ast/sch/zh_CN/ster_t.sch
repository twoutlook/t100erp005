/* 
================================================================================
檔案代號:ster_t
檔案名稱:專櫃結算單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table ster_t
(
sterent       number(5)      ,/* 企業編號 */
sterunit       varchar2(10)      ,/* 應用組織 */
stersite       varchar2(10)      ,/* 所屬組織 */
sterdocno       varchar2(20)      ,/* 單據編號 */
sterdocnt       date      ,/* 單據日期 */
sterstus       varchar2(10)      ,/* 狀態碼 */
ster001       varchar2(20)      ,/* 合約編號 */
ster002       varchar2(10)      ,/* 供應商編號 */
ster003       varchar2(10)      ,/* 經營方式 */
ster004       varchar2(10)      ,/* 結算帳期 */
ster005       date      ,/* 起始日期 */
ster006       date      ,/* 截止日期 */
ster007       number(20,6)      ,/* 上期結存金額 */
ster008       number(20,6)      ,/* 本期銷貨成本 */
ster009       number(20,6)      ,/* 本期進貨金額 */
ster010       number(20,6)      ,/* 本期退貨金額 */
ster011       number(20,6)      ,/* 本期折讓金額 */
ster012       number(20,6)      ,/* 稅額 */
ster013       number(20,6)      ,/* 價稅合計 */
ster014       number(20,6)      ,/* 本期預付金額 */
ster015       number(20,6)      ,/* 本期價外扣款 */
ster016       varchar2(1)      ,/* 貨款扣費用否 */
ster017       number(20,6)      ,/* 應結算金額 */
ster018       number(20,6)      ,/* 實際計算付金額 */
ster019       number(20,6)      ,/* 本期結存金額 */
ster020       varchar2(10)      ,/* 結算標識 */
ster021       varchar2(20)      ,/* 人員 */
ster022       varchar2(10)      ,/* 部門 */
ster023       varchar2(10)      ,/* 結算地點 */
ster024       varchar2(20)      ,/* 納稅編號 */
ster025       varchar2(15)      ,/* 銀行編號 */
ster026       varchar2(30)      ,/* 銀行賬號 */
ster027       date      ,/* 發票日期 */
ster028       varchar2(20)      ,/* 發票號碼 */
ster029       date      ,/* 付款日期 */
ster030       varchar2(20)      ,/* 發票人 */
ster031       date      ,/* 生效日期 */
ster032       date      ,/* 失效日期 */
ster033       varchar2(255)      ,/* 備註 */
ster034       number(20,6)      ,/* 主帳套帳款金額 */
ster035       number(20,6)      ,/* 次帳套一帳款金額 */
ster036       number(20,6)      ,/* 次帳套二帳款金額 */
ster037       varchar2(10)      ,/* 專櫃編號 */
sterownid       varchar2(20)      ,/* 資料所有者 */
sterowndp       varchar2(10)      ,/* 資料所屬部門 */
stercrtid       varchar2(20)      ,/* 資料建立者 */
stercrtdp       varchar2(10)      ,/* 資料建立部門 */
stercrtdt       timestamp(0)      ,/* 資料創建日 */
stermodid       varchar2(20)      ,/* 資料修改者 */
stermoddt       timestamp(0)      ,/* 最近修改日 */
stercnfid       varchar2(20)      ,/* 資料確認者 */
stercnfdt       timestamp(0)      ,/* 資料確認日 */
sterpstid       varchar2(20)      ,/* 資料過帳者 */
sterpstdt       timestamp(0)      /* 資料過帳日 */
);
alter table ster_t add constraint ster_pk primary key (sterent,sterdocno) enable validate;

create unique index ster_pk on ster_t (sterent,sterdocno);

grant select on ster_t to tiptop;
grant update on ster_t to tiptop;
grant delete on ster_t to tiptop;
grant insert on ster_t to tiptop;

exit;
