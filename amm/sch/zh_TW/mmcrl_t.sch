/* 
================================================================================
檔案代號:mmcrl_t
檔案名稱:會員等級升降策略申請單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mmcrl_t
(
mmcrlent       number(5)      ,/* 企業編號 */
mmcrldocno       varchar2(20)      ,/* 單號 */
mmcrl001       varchar2(6)      ,/* 語言別 */
mmcrl002       varchar2(500)      ,/* 說明 */
mmcrl003       varchar2(10)      /* 助記碼 */
);
alter table mmcrl_t add constraint mmcrl_pk primary key (mmcrlent,mmcrldocno,mmcrl001) enable validate;

create unique index mmcrl_pk on mmcrl_t (mmcrlent,mmcrldocno,mmcrl001);

grant select on mmcrl_t to tiptop;
grant update on mmcrl_t to tiptop;
grant delete on mmcrl_t to tiptop;
grant insert on mmcrl_t to tiptop;

exit;
