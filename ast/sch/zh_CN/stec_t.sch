/* 
================================================================================
檔案代號:stec_t
檔案名稱:專櫃合同庫區費用申请設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stec_t
(
stecent       number(5)      ,/* 企業編號 */
stecsite       varchar2(10)      ,/* 營運據點 */
stecunit       varchar2(10)      ,/* 應用組織 */
stecdocno       varchar2(20)      ,/* 單據編號 */
stecseq       number(10,0)      ,/* 項次 */
stec001       varchar2(20)      ,/* 合同編號 */
stec002       varchar2(10)      ,/* 庫區編號 */
stec003       varchar2(500)      ,/* 庫區名稱 */
stec004       varchar2(10)      ,/* 經營小類 */
stec005       varchar2(10)      ,/* 經營品牌 */
stec006       varchar2(10)      ,/* 進項稅 */
stec007       varchar2(10)      ,/* 銷項稅 */
stec008       number(5,2)      ,/* 消費稅率 */
stec009       varchar2(10)      ,/* 費用編號 */
stec010       varchar2(10)      ,/* 會計期間 */
stec011       varchar2(10)      ,/* 價款類別 */
stec012       varchar2(10)      ,/* 計算類型 */
stec013       varchar2(10)      ,/* 費用週期 */
stec014       varchar2(10)      ,/* 費用週期方式 */
stec015       varchar2(10)      ,/* 條件基準 */
stec016       varchar2(10)      ,/* 計算基準 */
stec017       number(20,6)      ,/* 費用淨額 */
stec018       number(20,6)      ,/* 費用比率 */
stec019       date      ,/* 生效日期 */
stec020       date      ,/* 失效日期 */
stec021       date      ,/* 下次計算日 */
stec022       date      ,/* 下次費用開始日 */
stec023       date      ,/* 下次費用截止日 */
stec024       varchar2(10)      ,/* 庫區用途分類 */
stec025       varchar2(10)      ,/* 對應常規庫區編號 */
stec026       varchar2(1)      ,/* 納入結算單否 */
stec027       varchar2(1)      ,/* 票扣否 */
stecacti       varchar2(1)      /* 有效 */
);
alter table stec_t add constraint stec_pk primary key (stecent,stecdocno,stecseq) enable validate;

create unique index stec_pk on stec_t (stecent,stecdocno,stecseq);

grant select on stec_t to tiptop;
grant update on stec_t to tiptop;
grant delete on stec_t to tiptop;
grant insert on stec_t to tiptop;

exit;
