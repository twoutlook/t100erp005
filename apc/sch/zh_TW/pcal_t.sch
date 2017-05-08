/* 
================================================================================
檔案代號:pcal_t
檔案名稱:介面款別資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcal_t
(
pcalent       number(5)      ,/* 企業編號 */
pcalunit       varchar2(10)      ,/* 應用組織 */
pcalsite       varchar2(10)      ,/* 營運據點 */
pcal001       varchar2(10)      ,/* POS款別 */
pcal002       varchar2(10)      ,/* 對應款別編號 */
pcal003       varchar2(1)      ,/* 是否先輸入金額 */
pcal004       varchar2(1)      ,/* 可手工錄入號碼 */
pcal005       number(5,0)      ,/* 錄入號碼最小長度 */
pcal006       varchar2(1)      ,/* 可退款 */
pcal007       varchar2(1)      ,/* 可找零 */
pcal008       varchar2(1)      ,/* 可整單取消 */
pcal009       varchar2(1)      ,/* 可溢收 */
pcal010       varchar2(1)      ,/* 是否執行接口程序 */
pcal011       varchar2(1)      ,/* 扣款金額自動取值 */
pcal012       varchar2(1)      ,/* 接口小數倍數 */
pcal013       varchar2(1)      ,/* 允許空單交易 */
pcal014       varchar2(1)      ,/* transflag標記 */
pcal015       varchar2(80)      ,/* 接口程序返回的打印文件 */
pcal016       varchar2(80)      ,/* 執行的接口程序 */
pcal017       varchar2(80)      ,/* 執行接口傳入的文件名 */
pcal018       varchar2(80)      ,/* 執行接口傳入文件數據類型ID */
pcal019       varchar2(80)      ,/* 執行接口后返回接口文件 */
pcal020       varchar2(80)      ,/* 執行接口返回文件數據類型 */
pcalstamp       timestamp(5)      ,/* 時間戳記 */
pcalstus       varchar2(10)      ,/* 狀態碼 */
pcalownid       varchar2(20)      ,/* 資料所有者 */
pcalowndp       varchar2(10)      ,/* 資料所屬部門 */
pcalcrtid       varchar2(20)      ,/* 資料建立者 */
pcalcrtdp       varchar2(10)      ,/* 資料建立部門 */
pcalcrtdt       timestamp(0)      ,/* 資料創建日 */
pcalmodid       varchar2(20)      ,/* 資料修改者 */
pcalmoddt       timestamp(0)      ,/* 最近修改日 */
pcalud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcalud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcalud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcalud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcalud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcalud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcalud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcalud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcalud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcalud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcalud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcalud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcalud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcalud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcalud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcalud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcalud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcalud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcalud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcalud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcalud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcalud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcalud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcalud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcalud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcalud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcalud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcalud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcalud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcalud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcal_t add constraint pcal_pk primary key (pcalent,pcalsite,pcal001) enable validate;

create unique index pcal_pk on pcal_t (pcalent,pcalsite,pcal001);

grant select on pcal_t to tiptop;
grant update on pcal_t to tiptop;
grant delete on pcal_t to tiptop;
grant insert on pcal_t to tiptop;

exit;
