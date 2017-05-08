/* 
================================================================================
檔案代號:pcai_t
檔案名稱:POS參數基本資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcai_t
(
pcaient       number(5)      ,/* 企業編號 */
pcaiunit       varchar2(10)      ,/* 應用組織 */
pcai001       varchar2(60)      ,/* 參數編號 */
pcai002       varchar2(10)      ,/* 參數類型 */
pcai003       number(5,0)      ,/* 長度 */
pcai004       varchar2(10)      ,/* 參數分類 */
pcaistamp       timestamp(5)      ,/* 時間戳記 */
pcaistus       varchar2(10)      ,/* 狀態碼 */
pcaiownid       varchar2(20)      ,/* 資料所有者 */
pcaiowndp       varchar2(10)      ,/* 資料所屬部門 */
pcaicrtid       varchar2(20)      ,/* 資料建立者 */
pcaicrtdp       varchar2(10)      ,/* 資料建立部門 */
pcaicrtdt       timestamp(0)      ,/* 資料創建日 */
pcaimodid       varchar2(20)      ,/* 資料修改者 */
pcaimoddt       timestamp(0)      ,/* 最近修改日 */
pcaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcaiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcai_t add constraint pcai_pk primary key (pcaient,pcai001) enable validate;

create unique index pcai_pk on pcai_t (pcaient,pcai001);

grant select on pcai_t to tiptop;
grant update on pcai_t to tiptop;
grant delete on pcai_t to tiptop;
grant insert on pcai_t to tiptop;

exit;
