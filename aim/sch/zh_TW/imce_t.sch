/* 
================================================================================
檔案代號:imce_t
檔案名稱:料件據點採購分群檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imce_t
(
imceent       number(5)      ,/* 企業編號 */
imceownid       varchar2(20)      ,/* 資料所有者 */
imceowndp       varchar2(10)      ,/* 資料所屬部門 */
imcecrtid       varchar2(20)      ,/* 資料建立者 */
imcecrtdp       varchar2(10)      ,/* 資料建立部門 */
imcecrtdt       timestamp(0)      ,/* 資料創建日 */
imcemodid       varchar2(20)      ,/* 資料修改者 */
imcemoddt       timestamp(0)      ,/* 最近修改日 */
imcestus       varchar2(10)      ,/* 狀態碼 */
imcesite       varchar2(10)      ,/* 營運據點 */
imce141       varchar2(10)      ,/* 採購分群 */
imce142       varchar2(20)      ,/* 採購員 */
imce143       varchar2(10)      ,/* 採購單位 */
imce144       varchar2(10)      ,/* 採購計價單位 */
imce145       number(20,6)      ,/* 採購單位批量 */
imce146       number(20,6)      ,/* 最小採購數量 */
imce147       varchar2(10)      ,/* 採購批量控管方式 */
imce148       number(20,6)      ,/* 經濟訂購量 */
imce149       number(20,6)      ,/* 平均訂購量 */
imce151       varchar2(10)      ,/* 預設內外購 */
imce152       varchar2(10)      ,/* 廠商選擇方式 */
imce153       varchar2(10)      ,/* 主要供應商 */
imce154       number(20,6)      ,/* 主供應商分配限量 */
imce155       number(15,3)      ,/* 分配進位倍數 */
imce156       varchar2(10)      ,/* 供貨模式 */
imce157       varchar2(40)      ,/* 慣用包裝容器 */
imce158       varchar2(10)      ,/* 接單拆解方式(採購) */
imce161       varchar2(1)      ,/* 採購替代 */
imce162       varchar2(1)      ,/* 採購收貨替代 */
imce163       varchar2(1)      ,/* 採購合約沖銷 */
imce164       number(20,6)      ,/* 採購時損耗率 */
imce165       number(20,6)      ,/* 採購時備品率 */
imce166       number(20,6)      ,/* 採購超交率 */
imce171       number(15,3)      ,/* 採購文件前置時間 */
imce172       number(15,3)      ,/* 採購交貨前置時間 */
imce173       number(15,3)      ,/* 採購到廠前置時間 */
imce174       number(15,3)      ,/* 採購入庫前置時間 */
imce175       number(15,3)      ,/* 嚴守交期前置時間 */
imce176       varchar2(10)      ,/* 收貨時段 */
imceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imceud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imce_t add constraint imce_pk primary key (imceent,imcesite,imce141) enable validate;

create unique index imce_pk on imce_t (imceent,imcesite,imce141);

grant select on imce_t to tiptop;
grant update on imce_t to tiptop;
grant delete on imce_t to tiptop;
grant insert on imce_t to tiptop;

exit;
