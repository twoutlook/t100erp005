/* 
================================================================================
檔案代號:gzpg_t
檔案名稱:高頻排程執行設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzpg_t
(
gzpgent       number(5)      ,/* 企業代碼 */
gzpgownid       varchar2(20)      ,/* 資料所有者 */
gzpgowndp       varchar2(10)      ,/* 資料所屬部門 */
gzpgcrtid       varchar2(20)      ,/* 資料建立者 */
gzpgcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzpgcrtdt       timestamp(0)      ,/* 資料創建日 */
gzpgmodid       varchar2(20)      ,/* 資料修改者 */
gzpgmoddt       timestamp(0)      ,/* 最近修改日 */
gzpgstus       varchar2(10)      ,/* 狀態碼 */
gzpg001       number(5,0)      ,/* 排程編號 */
gzpg002       varchar2(20)      ,/* 排程作業 */
gzpg003       number(5,0)      ,/* 間隔時間 */
gzpg004       varchar2(8)      ,/* 起始時間 */
gzpg005       varchar2(8)      ,/* 結束時間 */
gzpg006       varchar2(10)      ,/* 執行營運據點 */
gzpg007       varchar2(20)      ,/* 執行使用者編號 */
gzpg008       varchar2(20)      ,/* 任務執行主機 */
gzpg009       varchar2(1)      ,/* 前一程序未完成時不執行新程序 */
gzpg010       timestamp(0)      ,/* 排程執行時間 */
gzpg011       number(5,0)      ,/* 容許等待時間(分鐘) */
gzpg012       varchar2(1)      ,/* 超過容許時間是否mail通知 */
gzpg013       varchar2(255)      ,/* 收件者mail */
gzpg014       varchar2(1)      ,/* 已通知 */
gzpg015       varchar2(20)      ,/* sessionkey */
gzpg016       varchar2(20)      /* PID */
);
alter table gzpg_t add constraint gzpg_pk primary key (gzpgent,gzpg001) enable validate;

create unique index gzpg_pk on gzpg_t (gzpgent,gzpg001);

grant select on gzpg_t to tiptop;
grant update on gzpg_t to tiptop;
grant delete on gzpg_t to tiptop;
grant insert on gzpg_t to tiptop;

exit;
