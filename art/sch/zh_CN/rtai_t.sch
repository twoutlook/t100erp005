/* 
================================================================================
檔案代號:rtai_t
檔案名稱:預設單別檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtai_t
(
rtaient       number(5)      ,/* 企業編號 */
rtai001       varchar2(5)      ,/* 參照表編號 */
rtai002       varchar2(4)      ,/* 模組別 */
rtai003       varchar2(20)      ,/* 對應作業編號 */
rtai004       varchar2(5)      ,/* 預設維護單據別編號 */
rtai005       varchar2(5)      ,/* 預設批次拋轉單據別編號 */
rtai006       varchar2(5)      ,/* 預設POS拋轉單據別編號 */
rtaiownid       varchar2(20)      ,/* 資料所有者 */
rtaiowndp       varchar2(10)      ,/* 資料所屬部門 */
rtaicrtid       varchar2(20)      ,/* 資料建立者 */
rtaicrtdp       varchar2(10)      ,/* 資料建立部門 */
rtaicrtdt       timestamp(0)      ,/* 資料創建日 */
rtaimodid       varchar2(20)      ,/* 資料修改者 */
rtaimoddt       timestamp(0)      ,/* 最近修改日 */
rtaistus       varchar2(10)      ,/* 狀態碼 */
rtaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtaiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtai_t add constraint rtai_pk primary key (rtaient,rtai001,rtai003) enable validate;

create unique index rtai_pk on rtai_t (rtaient,rtai001,rtai003);

grant select on rtai_t to tiptop;
grant update on rtai_t to tiptop;
grant delete on rtai_t to tiptop;
grant insert on rtai_t to tiptop;

exit;
